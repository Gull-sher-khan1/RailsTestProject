# frozen_string_literal: true

require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    add_dummy_data
    sign_in User.create(email: 'gullsher.khan@devsinc.com', password: '123456', password_confirmation: '123456',
                        first_name: 'gull sher', last_name: 'khan')
    @post = Post.last
    @user = User.last
    @comment_id = Comment.last.id
  end

  teardown do
    delete destroy_user_session_path
  end

  test 'show edit form' do
    get edit_comment_path(@comment_id), xhr: true
    assert_response :success
    assert_not_equal 'can not complete action, try reloading', flash[:alert]
  end

  test 'do not show edit form' do
    get edit_comment_path(0), xhr: true
    assert_equal 'can not complete action, try reloading', flash[:alert]
  end

  test 'do not create comment' do
    post user_comments_path(0), params: { comment: { commentable_id: 0 } }, xhr: true
    assert_equal 'can not create comment, try reloading', flash[:alert]
  end

  test 'create comment' do
    post user_comments_path(user_id: @user.id), params: { comment: { commentable_id: @post.id, text: 'asd' } },
                                                xhr: true
    assert_response :success
  end

  test 'do not create comment with null text' do
    post user_comments_path(user_id: @user.id), params: { comment: { commentable_id: @post.id, text: '' } }, xhr: true
    assert_equal 'can not create comment', flash[:alert]
  end

  test 'do not update comment' do
    patch comment_path(0), xhr: true
    assert_equal 'can not complete action, try reloading', flash[:alert]
  end

  test 'update comment' do
    patch comment_path(@comment_id), params: { comment: { text: 'abc' } }, xhr: true
    assert_response :success
  end

  test 'do not update comment with null text' do
    patch comment_path(@comment_id), params: { comment: { text: '' } }, xhr: true
    assert_equal 'can not update comment', flash[:alert]
  end

  test 'do not destroy comment' do
    delete comment_path(0), xhr: true
    assert_equal 'can not complete action, try reloading', flash[:alert]
  end

  test 'destroy comment' do
    delete comment_path(@comment_id), xhr: true
    assert_response :success
    delete comment_path(@comment_id), xhr: true
    assert_equal 'can not complete action, try reloading', flash[:alert]
  end

  test 'do not update comment without login' do
    delete destroy_user_session_path
    patch comment_path(@comment_id), params: { comment: { text: 'abc' } }, xhr: true
    assert_equal '/unauthenticated', request.fullpath
  end

  test 'do not create comment without login' do
    delete destroy_user_session_path
    post user_comments_path(user_id: @user.id), params: { comment: { commentable_id: @post.id, text: 'asd' } },
                                                xhr: true
    assert_equal '/unauthenticated', request.fullpath
  end

  test 'do not show edit form without login' do
    delete destroy_user_session_path
    get edit_comment_path(@comment_id), xhr: true
    assert_equal '/unauthenticated', request.fullpath
  end

  test 'do not destroy comment without login' do
    delete destroy_user_session_path
    delete comment_path(@comment_id), xhr: true
    assert_equal '/unauthenticated', request.fullpath
  end
end
