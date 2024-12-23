# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    add_dummy_data
    sign_in User.create(email: 'gullsher.khan@devsinc.com', password: '123456', password_confirmation: '123456',
                        first_name: 'gull sher', last_name: 'khan')
    @post = Post.last
    @user = User.last
  end

  teardown do
    delete destroy_user_session_path
  end

  test 'show edit form' do
    get edit_user_path(User.last.id), xhr: true
    assert_response :success
    assert_not_equal 'can not find user', flash[:alert]
  end

  test 'do not show edit form' do
    get edit_user_path(0), xhr: true
    assert_equal 'can not find user', flash[:alert]
  end

  test 'show user' do
    get user_path(User.last.id)
    assert_select 'form input[type=submit][value="Public Account"]'
    assert_response :success
  end

  test 'cant find user' do
    get user_path(0)
    assert_equal 'can not find user', flash[:alert]
  end

  test 'do not show user custom settings buttons' do
    get user_path(User.first.id)
    assert_select 'form input[type=submit][value="Follow"]'
    assert_response :success
  end

  test 'do not update user public account' do
    patch user_path(User.first.id), params: { from: :private }, xhr: true
    assert_equal 'can not perform action', flash[:alert]
  end

  test 'update user public account' do
    patch user_path(User.last.id), params: { from: :private }, xhr: true
    assert_response :success
  end

  test 'do not update different user name ' do
    patch user_path(User.first.id), params: { user: { first_name: 'gull', last_name: 'khan' } }, xhr: true
    assert_equal 'can not perform action', flash[:alert]
  end

  test 'do not update user name without finding user' do
    patch user_path(0), params: { user: { first_name: 'gull', last_name: 'khan' } }, xhr: true
    assert_equal 'can not find user', flash[:alert]
  end

  test 'do not update user name with null parameter key' do
    patch user_path(User.last.id), params: { user: { first_name: '', last_name: 'khan' } }, xhr: true
    assert_equal 'can not update user name', flash[:alert]
  end

  test 'update user name' do
    patch user_path(User.last.id), params: { user: { first_name: 'gull', last_name: 'khan' } }, xhr: true
    assert_response :success
  end

  test 'do not show edit form without login' do
    delete destroy_user_session_path
    get edit_user_path(User.last.id), xhr: true
    assert_equal '/unauthenticated', request.fullpath
  end

  test 'do not show user without login' do
    delete destroy_user_session_path
    get user_path(User.last.id)
    assert_equal '/unauthenticated', request.fullpath
  end

  test 'do not update account without login' do
    delete destroy_user_session_path
    patch user_path(User.last.id), params: { from: :private }, xhr: true
    assert_equal '/unauthenticated', request.fullpath
  end

  test 'do not update name without login' do
    delete destroy_user_session_path
    patch user_path(User.last.id), params: { user: { first_name: 'gull', last_name: 'khan' } }, xhr: true
    assert_equal '/unauthenticated', request.fullpath
  end
end
