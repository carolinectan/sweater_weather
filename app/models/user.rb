class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, require: true, confirmation: true

  has_secure_password
end
