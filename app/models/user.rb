class User < ApplicationRecord
  has_many :payment_methods, dependent: :destroy
  accepts_nested_attributes_for :payment_methods, allow_destroy: true
  has_many :purchases, through: :payment_methods
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, :last_name, :company_name, presence: true
end
