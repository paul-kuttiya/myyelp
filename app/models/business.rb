class Business < ActiveRecord::Base
  has_many :reviews

  default_scope { order('created_at DESC') }
  validates_presence_of :name, :address, :city, :state, :zip, :phone 
  validates_uniqueness_of :address, :phone

  def reviews_count
    reviews.size
  end

  def last_review
    reviews.first.description
  end

  def last_reviewer
    reviews.last.user
  end

  def rating
    reviews_total = reviews.map(&:rating).inject(:+) 
    reviews_size = reviews.size
    (reviews_total / reviews_size).ceil
  end
end