# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# user = User.new
# user.first_name='Anonymous'
# user.last_name='User'
# user.email='anonymous@gmail.com'
# user.confirmed_at=DateTime.now
# user.save
user = User.create(first_name: 'test', last_name: 'one', email: 'gsk@gmail.com', password: '123456', password_confirmation: '123456')
post = Post.create(text: 'first_post', user_id: user.id)
comment = post.comments.create(text: 'first_comment', user_id: user.id)
