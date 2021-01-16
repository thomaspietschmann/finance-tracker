class FriendshipsController < ApplicationController

  def destroy
    friend = User.find(params[:id])
    friendship = Friendship.find_by(user: current_user, friend: friend)
    friendship.delete
    redirect_to my_friends_path
  end


  def create
    friend = User.find(params[:friend])
    current_user.friends << friend
  end

end
