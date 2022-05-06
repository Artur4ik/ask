class QuestionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    question = Question.create(body: params[:question][:body],
                               user_id: params[:question][:user_id])

    is_valid_user = User.exists?(id: params[:question][:user_id])
    is_body_empty = params[:question][:body].blank?

    if (is_valid_user && !is_body_empty)
      flash[:primary] = t('questions.question_created')
      redirect_to question_path(id: question.id)
    else
      flash[:danger] = "Пользователь с таким id не существует" unless is_valid_user
      flash[:danger] = "Вопрос не может быть пустым" if is_body_empty
      redirect_to new_question_path
    end

  end

  def index
    @questions = Question.all
    @users = User.all
  end

  def update
    answer = Answer.create(body: params[:answer][:body],
                           question_id: params[:id],
                           user_id: params[:answer][:user_id])

    is_valid_user = User.exists?(id: params[:answer][:user_id])
    is_valid_question = Question.exists?(id: params[:id])
    is_body_empty = params[:answer][:body].blank?

    if (is_valid_user && is_valid_question && !is_body_empty)
      flash[:primary] = t('questions.answer_created')
      redirect_to question_path(id: params[:id])
    else
      flash[:danger] = "Пользователь с таким id не существует" unless is_valid_user
      flash[:danger] = "Вопрос с таким id не существует" unless is_valid_question
      flash[:danger] = "Ответ не может быть пустым" if is_body_empty
      redirect_to question_path(id: params[:id])
    end
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
    redirect_to question_path(id: question.id)
  end
end
