class LikesController < ApplicationController
  before_action :likes_handler

  def create
    likes_handler.perform
    render json
    end
  end

  def index
    render json: Like.targeted_list(params[:target_id], params[:target_type])
    render json: Like.where(
      target_id: params[:target_id],
      target_type: params[:target_type])
  end

  private

  def likes_handler
    @likes_handler = Handlers::Like.new(strong_params)
  end

  def strong_params
    params.permit!(:user_id, :target_id, :target_type, :emoji)
  end
end
