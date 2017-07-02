class ReviewsController < ApplicationController
  def index
    @reviews = Review.limit(10)
  end
end