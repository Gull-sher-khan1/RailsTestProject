# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :redirect_if_not_signed_in, unless: :user_signed_in?
  rescue_from ActionController::InvalidAuthenticityToken, with: :invalid_token

  private

  def invalid_token
    render file: 'public/invalid'
  end

  def redirect_if_not_signed_in
    redirect_to root_url, alert: 'Please sign in!'
  end
end
