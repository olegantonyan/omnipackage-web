# frozen_string_literal: true

::ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'sidekiq/testing'

::Sidekiq::Testing.fake!

module ActiveSupport
  class TestCase
    include ::FactoryBot::Syntax::Methods

    parallelize(workers: :number_of_processors)

    def sign_in_as(user)
      post(sign_in_url, params: { email: user.email, password: 'Secret1*3*5*' })
      user
    end
  end
end
