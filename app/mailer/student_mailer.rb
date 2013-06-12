class StudentMailer < ActionMailer::Base
  default from: 'Rails Girls Summer of Code <summer-of-code-students@railsgirls.com>'

  def acceptance_email(receiver)
    mail to: receiver, subject: 'Rails Girls Summer of Code: student selection'
  end
end
