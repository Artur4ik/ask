class AnswersController < ApplicationController
  before_action :check_user_signed_in

  def create
    @questions_handler = Handlers::QuestionsHandler.new
    messages = @questions_handler.add_answer(params[:answer][:body],
                                             params[:answer][:user_id],
                                             params[:answer][:question_id])

    show_messages(messages)

    redirect_to(user_question_path(id: params[:answer][:question_id], user_id: params[:answer][:user_id]))
  end

  def update
    answer = Answer.find(params[:id])
    if(answer.valid? && (current_user.id == answer.user_id))
      answer.update_attribute(:body, params[:body])
      render(json: answer)
    else
      render(json: {data: "Error: answer not valid"})
    end
  end

  def destroy
    answer = Answer.find(params[:id])
    if(answer.valid? && (current_user.id == answer.user_id))
      answer.destroy
      render(json: {data: "success"})
    else
      render(json: {data: "Error: answer not valid"})
    end
  end

  private

  def check_user_signed_in
    redirect_to(new_user_session_path) unless user_signed_in?
  end

  def show_messages(message_hash)
    message_hash.each do |message, alert|
      flash[alert] = t(message)
    end
  end
end
