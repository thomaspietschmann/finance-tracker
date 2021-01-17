class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def under_stock_limit?
    stocks.count < 10
  end

  def stock_already_tracked?(ticker_symbol)
    stock = Stock.check_db(ticker_symbol)
    return false unless stock

    stocks.include? stock
    # stocks.where(id: stock.id).exists?
  end

  def can_track_stock?(ticker_symbol)
    under_stock_limit? && !stock_already_tracked?(ticker_symbol)
  end

  def full_name
    return "#{first_name} #{last_name}" if first_name || last_name
    "Anonymous"
  end

  def self.search(query)
    query.strip!
    to_send_back = (first_name_matches(query) + last_name_matches(query) + email_matches(query)).uniq
    return nil unless to_send_back
    to_send_back
  end

  def self.first_name_matches(query)
    matches("first_name", query)
  end

  def self.last_name_matches(query)
    matches("last_name", query)
  end

  def self.email_matches(query)
    matches("email", query)
  end

  def self.matches(field_name, query)
    where("#{field_name} like ?", "%#{query}%")
  end

  def except_current_user(users)
    users.reject { |user| user.id == self.id }
  end

  def not_friends_with?(friend_id)
    !self.friends.where(id: friend_id).exists?
  end

  # def filter_existing_friends(users)
  #   users.reject {|user| self.friends.include? user }
  # end


end
