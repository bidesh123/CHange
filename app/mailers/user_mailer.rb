class UserMailer < ActionMailer::Base
  default :from => "no-reply@lostbets.com"

  def registration_confirmation(user)
    @user = user
    @account_activation_url = activates_url(user.perishable_token)
    mail(:from => "no-reply@lostbets.com",
      :to => "#{user.username} <#{user.email}>",
      :subject => "Registered")
  end

  def deliver_password_reset_instructions(user)
    @user = user
    @edit_password_reset_url = edit_password_reset_url(user.perishable_token)
    mail(:from => "no-reply@lostbets.com",
      :to => "#{user.username} <#{user.email}>",
      :subject => "Password Reset Instructions")
  end

  def welcome(user)
    @user = user
    @root_url = root_url
    mail(:from => "no-reply@lostbets.com",
      :to => "#{user.username} <#{user.email}>",
      :subject => "Welcome to the site!")
  end
end
