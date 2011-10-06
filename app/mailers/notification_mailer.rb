# coding: utf-8

class NotificationMailer < ActionMailer::Base
  default :from => 'info@lazyhackers.com',
          :bcc => 'yuta@lazyhackers.com'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification_mailer.sendmail_cheer.subject
  #
  def sendmail_cheer(user_email, current_user, hack_tags)
    @current_user = current_user
    @hack_tags = hack_tags

    mail(:to => user_email, :subject=>'がんばれ！')
  end
  
  def sendmail_congrats(user_email, hack_tags, scope, current_user)
    @hack_tags = hack_tags
    @scope = scope
    @current_user = current_user
    
    mail(:to => user_email, :subject=>'おめでとう！')
  end
end
