# frozen_string_literal: true

module AgentApi
  class ApiController < ::ActionController::Base # rubocop: disable Rails/ApplicationController
    before_action :authorize
    skip_before_action :verify_authenticity_token
    rescue_from ::StandardError, with: :respond_error

    def call # rubocop: disable Metrics/MethodLength
      url_methods = ::Task::Scheduler::UrlMethods.new(method(:agent_api_download_sources_tarball_url))
      scheduler = ::Task::Scheduler.new(current_agent, url_methods)
      response_payload = scheduler.call(params.fetch(:payload))

      next_poll_after = rand(19..29)
      current_agent.touch_last_seen(next_poll_after)
      response.set_header('X-NEXT-POLL-AFTER-SECONDS', next_poll_after)
      if response_payload.is_a?(::Hash)
        render(json: response_payload)
      else
        head(:ok)
      end
    end

    def sources_tarball
      sources_tarball = current_agent.agent_tasks.find(params[:agent_task_id]).sources_tarball
      send_data(sources_tarball.decrypted_tarball, filename: sources_tarball.decrypted_tarball_filename)
    end

    private

    attr_reader :current_agent

    def authorize
      @current_agent = ::Agent.find_by(apikey: request.headers['X-APIKEY'] || params[:apikey])
      head(:unauthorized) unless current_agent
    end

    def respond_error(exception)
      payload = { error: exception.message }
      ::Rails.logger.error(exception.message)
      ::Rails.logger.error(exception.backtrace)
      # payload[:backtrace] = exception.backtrace if ::Rails.env.local?
      render(json: payload, status: :unprocessable_entity)
    end
  end
end
