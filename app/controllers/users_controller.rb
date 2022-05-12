class UsersController < ApplicationController
  def following
    @users = User.find(params[:user_id]).following
  end

  def followed
    @users = User.find(params[:user_id]).followers
  end

  def feed
    unless user_signed_in?
      redirect_to(root_path) and return
    end
    @questions = User.find(current_user.id).feed
    @users = User.find(current_user.id).following
  end

  def index
    @questions = Question.all
    @users = User.all
  end
end
