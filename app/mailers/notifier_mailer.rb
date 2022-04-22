class NotifierMailer < ApplicationMailer
  default from: ENV['MAILER_USER_NAME']

  def welcome(recipient)
    @recipient = recipient
    @u = User.find_by(email: @recipient)
    mail(to: recipient, subject: "[#{t('notifier_mailer.account')}] #{t('notifier_mailer.welcome')}")
  end

  def user_edit_notify

  end

  def questions_notify
    @users = User.all
    @q = Question.all
    @users.each do |user|
      mail(to: user.email, subject: "[#{t('notifier_mailer.notify')}] #{t('notifier_mailer.check_questions')}")
    end
  end
end
