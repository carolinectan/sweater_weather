class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true, empty: false
  validates_presence_of :password, require: true, confirmation: true, empty: false
  validates :api_key, presence: true, uniqueness: true
  has_secure_password
end
