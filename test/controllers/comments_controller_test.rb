# frozen_string_literal: true

require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    Rails.application.load_seed
    sign_in User.create(email: 'gullsher.khan@devsinc.com', password: '123456', password_confirmation: '123456', first_name: 'gull sher', last_name: 'khan')
    @post = Post.last
    @user = User.last
  end

  test "should show edit form" do
    get edit_comment_url(Comment.last.id), xhr: true
    assert_response :success
    assert_not_equal 'can not complete action, try reloading', flash[:alert]
  end

  test "should not show edit form" do
    get edit_comment_url(0), xhr: true
    assert_equal 'can not complete action, try reloading', flash[:alert]
  end

  test "should not create comment" do
    post user_comments_url(0), params:{comment:{commentable_id: 0}}, xhr: true
    assert_equal 'can not create comment, try reloading', flash[:alert]
  end

  test "should create comment" do
    post user_comments_url(user_id: @user.id), params:{comment:{commentable_id: @post.id, text: 'asd'}}, xhr: true
    assert_response :success
  end

  test "should not create comment with null text" do
    post user_comments_url(user_id: @user.id), params:{comment:{commentable_id: @post.id, text: ''}}, xhr: true
    assert_equal 'can not create comment', flash[:alert]
  end

  test "should not update comment" do
    patch comment_path(0), xhr: true
    assert_equal 'can not complete action, try reloading', flash[:alert]
  end

  test "should update comment" do
    patch comment_path(Comment.last.id), params:{comment:{text: 'abc'}}, xhr: true
    assert_response :success
  end

  test "should not destroy comment" do
    delete comment_path(0), xhr: true
    assert_equal 'can not complete action, try reloading', flash[:alert]
  end

  test "should destroy comment" do
    delete comment_path(Comment.last.id), xhr: true
    assert_response :success
  end

end
