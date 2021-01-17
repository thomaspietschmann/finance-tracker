class StocksController < ApplicationController
  def search
    if params[:stock].present?
      @stock = Stock.new_lookup(params[:stock])
      if @stock
        respond_to do |format| # respond to ajax request from form
          format.js { render partial: 'users/results' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = 'Please enter a valid symbol to search.'
          format.js { render partial: 'users/results' }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = 'Please enter a symbol to search.'
        format.js { render partial: 'users/results' }
      end
    end
  end

  def update
    stock = Stock.find(params[:id])
    old_price = stock.last_price
    stock.update_price
    flash[:alert] = "Price updated from #{old_price} to #{stock.last_price}"
    redirect_to my_portfolio_path
  end

end
