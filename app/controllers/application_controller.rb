# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  rescue_from ActionController::InvalidAuthenticityToken, with: :invalid_token

  private

  def invalid_token
    render file: 'public/invalid'
  end
end
