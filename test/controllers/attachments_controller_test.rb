# frozen_string_literal: true

require 'test_helper'

class AttachmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    Rails.application.load_seed
    sign_in User.create(email: 'gullsher.khan@devsinc.com', password: '123456', password_confirmation: '123456', first_name: 'gull sher', last_name: 'khan')
    @post = Post.last
    @user = User.last
  end
end
