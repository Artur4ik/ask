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

    redirect_to(user_questions_path) and return if messages.success?
    redirect_to(new_user_question_path) unless messages.success?
  end

  def index
    @questions = Question.where(user_id: params[:user_id]).paginate(page: params[:page])
  end

  def update
    messages = @questions_handler.add_answer(params[:answer][:body],
                                             params[:answer][:user_id],
                                             params[:id])

    show_messages(messages)

    redirect_to(user_question_path(id: params[:id], user_id: params[:answer][:user_id]))
  end

  def show
    @question = Question.find(params[:id]).increment!(:views)
  end

  def user
    @questions = Question.where(user_id: params[:id])
  end

  def feed

  end

  def destroy
    render(html: "Error") and return if (Question.find(params[:id]).user.id != current_user.id)
    messages = @questions_handler.delete_question(params[:id])

    show_messages(messages)

    redirect_to(user_questions_path)
  end

  def edit
    render(html: "Error") and return if (Question.find(params[:id]).user.id != current_user.id)
    messages = @questions_handler.change_solved_status(params[:id])

    show_messages(messages)

    redirect_to(user_question_path(id: params[:id], user_id: current_user.id))
  end

  private

  def show_messages(message_hash)
    message_hash.each do |message, alert|
      flash[alert] = t(message)
    end
  end
end
