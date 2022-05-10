class QuestionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :create_questions_handler

  def create_questions_handler
    @questions_handler = Handlers::QuestionsHandler.new
  end

  def create
    messages = @questions_handler.add_question(params[:question][:body],
                                               params[:question][:user_id])

    show_messages(messages)

    redirect_to(question_path(Question.last.id)) and return if messages.success?
    redirect_to(new_question_path) unless messages.success?
  end

  def index
    @questions = Question.all
    @users = User.all
  end

  def update
    messages = @questions_handler.add_answer(params[:answer][:body],
                                             params[:answer][:user_id],
                                             params[:id])

    show_messages(messages)

    redirect_to(question_path(id: params[:id]))
  end

  def show
    @question = Question.find(params[:id])
  end

  def user
    @questions = Question.where(user_id: params[:id])
  end

  def destroy
    messages = @questions_handler.delete_question(params[:id])

    show_messages(messages)

    redirect_to(questions_path)
  end

  def edit
    messages = @questions_handler.change_solved_status(params[:id])

    show_messages(messages)

    redirect_to(question_path(id: params[:id]))
  end

  private

  def show_messages(message_hash)
    message_hash.each do |message, alert|
      flash[alert] = t(message)
    end
  end
end
