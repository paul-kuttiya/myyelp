class User < ActiveRecord::Base
  has_secure_password validations: false
  validates_presence_of :first_name, :last_name, :email, :zip, :password
  validates_uniqueness_of :email
end