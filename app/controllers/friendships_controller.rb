class FriendshipsController < ApplicationController

  def destroy
    # friend = User.find(params[:id])
    # friendship = Friendship.find_by(user: current_user, friend: friend)
    friendship = current_user.friendships.find_by(friend_id: params[:id])
    friendship.delete
    flash[:notice] = "Stopped following"
    redirect_to my_friends_path
  end


  def create
    friend = User.find(params[:friend])
    current_user.friendships.build(friend_id: friend.id)
    if current_user.save
      flash[:notice] = "Following user"
    else
      flash[:alert] = "something went wrong"
    end
    redirect_to my_friends_path
  end

end
