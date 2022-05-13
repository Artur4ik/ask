class PagesController < ApplicationController
  def home
    redirect_to(user_feed_path) if user_signed_in?
  end

  def about
    @questions = Question.where(views: Question.maximum("views")).paginate(page: params[:page])
    @user = User.first
  end
end
