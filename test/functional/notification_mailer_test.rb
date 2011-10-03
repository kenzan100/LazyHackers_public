require 'test_helper'

class NotificationMailerTest < ActionMailer::TestCase
  test "sendmail_cheer" do
    mail = NotificationMailer.sendmail_cheer
    assert_equal "Sendmail cheer", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
