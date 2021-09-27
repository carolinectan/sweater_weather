class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true, empty: false
  validates_presence_of :password, require: true, confirmation: true, empty: false

  has_secure_password
end
