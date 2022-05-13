class RelationshipsController < ApplicationController
  def create
    current_user.follow(User.find(params[:followed_id]))
    flash[:success] = t('relation.create')
    redirect_to(user_questions_path(user_id: params[:followed_id]))
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
    flash[:success] = t('relation.destroy')
    redirect_to(user_questions_path(user_id: @user.id))
  end
end
