# frozen_string_literal: true

require 'test_helper'

class AttachmentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    add_dummy_data
    sign_in User.create(email: 'gullsher.khan@devsinc.com', password: '123456', password_confirmation: '123456',
                        first_name: 'gull sher', last_name: 'khan')
    @post = Post.last
    @user = User.last
    @seed_user = User.find_by(email: 'gsk1@gmail.com')
    @dispatch_file = Rack::Test::UploadedFile.new("#{Rails.root}/lib/assets/test.jpg", 'image/jpg')
  end

  teardown do
    delete destroy_user_session_path
  end

  test 'should not create post attachment' do
    post user_attachments_path(@seed_user.id), params: { post_id: 0, from: 'post', attachment: { attachment: nil } }
    assert_equal 'can not find post', flash[:alert]
  end

  test 'should upload and create post attachment' do
    post user_attachments_path(@seed_user.id),
         params: { post_id: @seed_user.posts.first.id, from: 'post', attachment: { attachment: [@dispatch_file] } }
    assert_response :redirect
  end

  test 'should not create user attachment' do
    post user_attachments_path(0), params: { post_id: 0, from: 'user', attachment: { attachment: nil } }
    assert_equal 'can not find user', flash[:alert]
  end

  test 'should upload and create user attachment' do
    post user_attachments_path(@seed_user.id), params: { from: 'user', attachment: { attachment: @dispatch_file } },
                                               xhr: true
    assert_response :success
  end

  test 'should create story attachment' do
    post user_attachments_path(@seed_user.id), params: { from: 'story', attachment: { attachment: @dispatch_file } },
                                               xhr: true
    assert_response :success
  end

  test 'should not update user attachment' do
    patch attachment_path(id: 0), params: { from: 'user', attachment: { attachment: nil } }
    assert_equal 'can not update attachment', flash[:alert]
  end

  test 'should update user attachment' do
    patch attachment_path(id: @seed_user.attachment.id),
          params: { from: 'user', attachment: { attachment: @dispatch_file } }, xhr: true
    assert_response :success
  end

  test 'should not update post attachments' do
    patch attachment_path(id: 0), params: { from: 'post', attachment: { attachment: nil } }
    assert_equal 'can not find post', flash[:alert]
  end

  test 'should update post attachments' do
    patch attachment_path(id: @post.id), params: { from: 'post', attachment: { attachment: [@dispatch_file] } }
    assert_response :redirect
  end

  test 'should not create post attachment without login' do
    delete destroy_user_session_path
    post user_attachments_path(@seed_user.id),
         params: { post_id: @seed_user.posts.first.id, from: 'post', attachment: { attachment: [@dispatch_file] } }
    assert_equal '/unauthenticated', request.fullpath
  end

  test 'should not create user attachment without login' do
    delete destroy_user_session_path
    post user_attachments_path(@seed_user.id), params: { from: 'user', attachment: { attachment: @dispatch_file } },
                                               xhr: true
    assert_equal '/unauthenticated', request.fullpath
  end

  test 'should not create story attachment without login' do
    delete destroy_user_session_path
    post user_attachments_path(@seed_user.id), params: { from: 'story', attachment: { attachment: @dispatch_file } },
                                               xhr: true
    assert_equal '/unauthenticated', request.fullpath
  end

  test 'should not update user attachment without login' do
    delete destroy_user_session_path
    patch attachment_path(id: @seed_user.attachment.id),
          params: { from: 'user', attachment: { attachment: @dispatch_file } }, xhr: true
    assert_equal '/unauthenticated', request.fullpath
  end

  test 'should not update post attachments without login' do
    delete destroy_user_session_path
    patch attachment_path(id: @post.id), params: { from: 'post', attachment: { attachment: [@dispatch_file] } }
    assert_equal '/unauthenticated', request.fullpath
  end
end
