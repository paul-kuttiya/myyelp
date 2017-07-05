class Business < ActiveRecord::Base
  has_many :reviews

  default_scope { order('created_at DESC') }
  validates_presence_of :name, :address, :city, :state, :zip, :phone 
  validates_uniqueness_of :address, :phone

  def reviews_count
    reviews.size
  end

  def last_review
    reviews.first.description if has_review?
  end

  def last_reviewer
    reviews.last.user if has_review?
  end

  def rating
    reviews_total = reviews.map(&:rating).inject(:+) || 0
    reviews_size = reviews.size
    reviews_total == 0 ?  0 : (reviews_total / reviews_size).ceil
  end

  private
  def has_review?
    reviews.size > 0
  end
end