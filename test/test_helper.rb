# frozen_string_literal: true

require 'simplecov'
SimpleCov.start
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
module ActiveSupport
  class TestCase
    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all
    def add_dummy_data
      link = 'https://res.cloudinary.com/dwp8xmdhf/image/upload/v1657214446/rails_test_project/jbxiauzzogdvpcs7j53d.jpg'
      user = User.create!(first_name: 'test', last_name: 'one', email: 'gsk1@gmail.com', password: '123456', password_confirmation: '123456')
      post = Post.create!(text: 'first_post', user_id: user.id)
      post.comments.create(text: 'first_comment', user_id: user.id)
      user.create_attachment(uri: link)
      post.attachments.create([{uri: link},{uri: link}])
    end

    # Add more helper methods to be used by all tests here...
  end
end
