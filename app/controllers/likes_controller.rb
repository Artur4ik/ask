class LikesController < ApplicationController
  before_action :create_likes_handler

  def create_likes_handler
    @likes_handler = Handlers::LikesHandler.new(strong_params)
  end

  def create
    render(json: @likes_handler.perform)
  end

  private

  def strong_params
    params.permit(:user_id, :target_id, :target_type, :emoji)
  end
end
