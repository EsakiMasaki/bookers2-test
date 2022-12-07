class RelationshipsController < ApplicationController
  def create
    relationship = current_user.relationships.new(followed_id: params[:user_id])
    relationship.save
    redirect_to request.referer
  end

  def destroy
    relationship = current_user.relationships.find_by(followed_id: params[:user_id])
    relationship.destroy
    redirect_to request.referer
  end

  def followings
  end

  def followers
  end
end
