class QuestionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    @q = Question.create(
      body:params[:post][:body],
      user_id:params[:post][:user_id],
      answer:"",
      answer_user_id:-1
    )
    redirect_to question_path(@q.id)
  end
  def index
    @q = Question.all
  end

  def update
    @q = Question.find(params[:id])
    @q.answer = params[:question][:answer]
    @q.answer_user_id = params[:question][:answer_user_id]
    @q.save
    redirect_to question_path(@q.id)
  end
  def show
    @q = Question.find(params[:id])
  end
  def destroy
    @q = Question.find(params[:id])
    @q.destroy
    redirect_to questions_path
  end
end
