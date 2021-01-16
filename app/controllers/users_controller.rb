class UsersController < ApplicationController
  def my_portfolio
    @tracked_stocks = current_user.stocks
  end

  def my_friends
    @my_friends = current_user.friends
  end


  def search
    if params[:query].present?
      @friends = User.search(params[:query])
      @friends = current_user.except_current_user(@friends)
      @friends = current_user.filter_existing_friends(@friends)
      if @friends
        respond_to do |format|
          format.js { render partial: 'users/friend_results' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = 'Please enter a valid symbol to search.'
          format.js { render partial: 'users/friend_results' }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = 'Please enter a valid symbol to search.'
        format.js { render partial: 'users/friend_results' }
      end
    end
  end

end



      # if @user
      #   respond_to do |format|
      #     format.js { render partial: 'users/friend_results' }
      #   end
      # else
      #   respond_to do |format|
      #     flash.now[:alert] = 'No user found.'
      #     format.js { render partial: 'users/friend_results'
      #   end
      # end

