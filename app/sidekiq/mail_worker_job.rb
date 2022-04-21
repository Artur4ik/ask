class MailWorkerJob
  include Sidekiq::Worker

  def perform
    NotifierMailer.questions_notify.deliver_now if (Question.all.count > 0)
    puts "Выполнена рассыкала уведомлений"
  end
end
