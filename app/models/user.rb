class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :cart
  has_many :addresses
  has_many :orders

  validates :first_name, :last_name, :phone, presence: true

  def full_name
    [first_name, last_name].reject(&:blank?).join(' ').titleize
  end
end
