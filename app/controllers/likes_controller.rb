class LikesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :create_likes_handler

  def create_likes_handler
    @likes_handler = Handlers::LikesHandler.new(strong_params)
  end

  def create
    render(json: "Error") and return if (!user_signed_in? || (params['user_id'].to_i != current_user.id))
    render(json: @likes_handler.perform)
  end

  private

  def strong_params
    params.delete(:locale)
    params.permit(:user_id, :target_id, :target_type, :emoji)
  end
end
