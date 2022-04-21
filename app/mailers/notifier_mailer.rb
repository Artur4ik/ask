class NotifierMailer < ApplicationMailer
  default from: 'artur4iku@gmail.com'

  def welcome(recipient)
    @recipient = recipient
    @u = User.find_by(email: @recipient)
    mail(to: recipient, subject: "[Регистрация] Добро пожаловать на ВсеВопросы.рф")
  end
end
