class LikesController < ApplicationController
  def create
    likes_on_target =
    Like.where(user_id: params[:user_id],
               target_id: params[:target_id],
               target_type: params[:target_type],
               emoji: params[:emoji])

    if likes_on_target.empty?
      Like.create(user_id: params[:user_id],
                  target_id: params[:target_id],
                  target_type: params[:target_type],
                  emoji: params[:emoji])
      index
    else
      destroy
    end
  end

  def destroy
    Like.where(
      user_id: params[:user_id],
      target_id: params[:target_id],
      target_type: params[:target_type],
      emoji: params[:emoji]).delete_all
      index
  end

  def index
    render json: Like.where(
      target_id: params[:target_id],
      target_type: params[:target_type])
  end
end
