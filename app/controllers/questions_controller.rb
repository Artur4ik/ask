class QuestionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    flash[:primary] = t('questions.question_created')
    question = Question.create(body: params[:question][:body],
                               user_id: current_user.id)
    redirect_to question_path(question.id)
  end

  def root

  end

  def index
    @questions = Question.all
    @users = User.all
  end

  def update
    flash[:primary] = t('questions.answer_added')
    Answer.create(body: params[:question][:body],
                  question_id: params[:id],
                  user_id: current_user.id)

    redirect_to question_path
  end

  def show
    @question = Question.find(params[:id])
  end

  def user
    @questions = Question.where(user_id:params[:id])
  end

  def destroy
    flash[:primary] = t('questions.question_deleted')
    Answer.where(question_id:params[:id]).delete_all
    Question.find(params[:id]).destroy
    redirect_to questions_path
  end

  def edit
    flash[:primary] = t('questions.question_status_changed')
    question = Question.find(params[:id])
    question.solved? ? question.solved = false : question.solved = true
    question.save
    redirect_to question_path(question.id)
  end
end
