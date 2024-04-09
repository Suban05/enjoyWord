class User < ApplicationRecord
  has_many :dictionaries
  
  has_secure_password

  validates :name, :password, presence: true
  validates :email, presence: true, uniqueness: true
end
