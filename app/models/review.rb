class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :business

  validates_presence_of :rating, :description
  validates_length_of :description, minimum: 5
  default_scope { order('created_at DESC') }

  def user_name
    "#{user.first_name}" 
  end

  def business_name
    business.name
  end
end