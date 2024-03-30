# Used to create main and send/deliver it to the users email id
class UserMailer < ApplicationMailer

  default from: 'information_vault@domain.com'

  # Creates a confirmation mail with the users registered email
  #
  # @param [User] user
  #
  # @return [Message]
  def account_confirmation(user)
    @user = user
    mail(to: "#{@user.username} <#{@user.email}>", subject: 'Email confirmation')
  end

end
