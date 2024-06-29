# frozen_string_literal: true

class User < ApplicationRecord
  has_many :dictionaries, dependent: :destroy

  has_secure_password

  validates :name, :password, presence: true
  validates :email, presence: true, uniqueness: true
end
