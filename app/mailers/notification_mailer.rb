# coding: utf-8

class NotificationMailer < ActionMailer::Base
  default :from => 'info@lazyhackers.com',
          :bcc => 'yuta@lazyhackers.com'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification_mailer.sendmail_cheer.subject
  #
  def sendmail_cheer(user, current_user, hack_tags)
    @user = user
    @current_user = current_user
    @hack_tags = hack_tags

    mail(:to => @user, :subject=>'がんばれ！')
  end
end
