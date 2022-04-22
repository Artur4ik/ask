class QuestionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    set_locale
    @q = Question.create(
      body:params[:post][:body],
      user_id:current_user.id
    )
    redirect_to question_path(@q.id)
  end
  def index
    set_locale
    @q = Question.all
    #@u = User.where('created_at >= ?', Date.today)
    @u = User.all
  end

  def update
    set_locale
    #@q = Question.find(params[:id])
    #@q.answer = params[:question][:answer]
    #@q.answer_user_id = params[:question][:answer_user_id]
    #@q.save
    Answer.create(body: params[:question][:answer],
                  question_id: params[:id],
                  answer_user_id: current_user.id)

    redirect_to question_path
  end
  def show
    set_locale
    @q = Question.find(params[:id])
    @a = Answer.where(question_id: @q.id)
  end
  def user
    set_locale
    @q = Question.where(user_id:params[:id])
  end
  def destroy
    set_locale
    Question.find(params[:id]).destroy
    Answer.where(question_id: params[:id]).delete_all
    redirect_to questions_path
  end
end
