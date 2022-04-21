class NotifierMailer < ApplicationMailer
  default from: 'artur4iku@gmail.com'

  def welcome(recipient)
    @recipient = recipient
    @u = User.find_by(email: @recipient)
    mail(to: recipient, subject: "[Учётная запись] Добро пожаловать на ВсеВопросы.рф")
  end

  def user_edit_notify

  end

  def questions_notify
    @users = User.all
    @q = Question.all
    @users.each do |user|
      mail(to: user.email, subject: "[Уведомление] Посмотрите новые вопросы на ВсеВопросы.рф")
    end
  end
end
