class User < ActiveRecord::Base
  has_many :reviews
  
  has_secure_password validations: false
  validates_presence_of :first_name, :last_name, :email, :zip, :password
  validates_uniqueness_of :email

  def full_name
    "#{first_name} #{last_name}"
  end

  def total_reviews
    reviews.size
  end

  def existing_review?(business)
    reviews.find_by(business: business)
  end
end