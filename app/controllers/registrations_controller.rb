class RegistrationsController < ApplicationController
  skip_before_action :require_authentication
  before_action :require_no_authentication

  def new
    @user = ::User.new
  end

  def create
    @user = ::User.new(user_params)

    if @user.save
      sign_in(@user)

      send_email_verification
      redirect_to(root_path, notice: 'Welcome! You have signed up successfully')
    else
      error_message = '<ul>' + @user.errors.map { |e| "<li>#{e.full_message}</li>" }.join + '</ul>'
      flash.now[:alert] = error_message.html_safe
      render(:new, status: :unprocessable_entity)
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

  def send_email_verification
    ::UserMailer.with(user: @user).email_verification.deliver_later
  end
end
