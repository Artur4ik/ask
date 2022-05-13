class PagesController < ApplicationController
  def home
    redirect_to(user_feed_path) if user_signed_in?
  end

  def about
    @questions = [Question.find_by(views: Question.maximum("views"))]
    @user = User.first
  end
end
