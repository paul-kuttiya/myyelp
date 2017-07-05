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

  def rating_details
    result = { 5 => 0, 4 => 0, 3 => 0, 2 => 0, 1 => 0 }
    user_ratings = reviews.map(&:rating)
    
    user_ratings.each do |n|
      result[n] += 1
    end

    result
  end

  def existing_review?(business)
    reviews.find_by(business: business)
  end
end