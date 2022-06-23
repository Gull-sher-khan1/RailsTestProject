class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = User.new(user)
    mail(to: @user.email, subject: "Welcome to Intaclone!")
  end
end
