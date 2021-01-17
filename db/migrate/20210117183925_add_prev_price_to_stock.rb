class AddPrevPriceToStock < ActiveRecord::Migration[6.0]
  def change
    add_column :stocks, :prev_price, :decimal
  end
end
