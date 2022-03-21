class QuestionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    Question.create(
      body:params[:post][:body],
      user_id:params[:post][:user_id]
    )
    redirect_to questions_path
  end
  def index
    @q = Question.all
  end

  def update
    @q = Question.find(params[:id])
    @q.update(
      body:params[:question][:body],
      user_id:params[:question][:user_id]
    )
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
