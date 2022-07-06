# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    Rails.application.load_seed
    sign_in User.create(email: 'gullsher.khan@devsinc.com', password: '123456', password_confirmation: '123456', first_name: 'gull sher', last_name: 'khan')
    @post = Post.last
    @user = User.last
  end

  test "show edit form" do
    get edit_user_url(User.last.id), xhr: true
    assert_response :success
    assert_not_equal 'can not find user', flash[:alert]
  end

  test "dont show edit form" do
    get edit_user_url(0), xhr: true
    assert_equal 'can not find user', flash[:alert]
  end
end
