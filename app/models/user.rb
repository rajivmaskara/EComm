class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :cart_line_items
  has_many :orders
  has_many :reviews

  #after_create :send_welcome_message

  def send_welcome_message
  	Notification.welcome_user_message(self).deliver
  end

end
