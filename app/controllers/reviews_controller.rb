class ReviewsController < ApplicationController
  before_action :require_user, only: [:new, :create]
  before_action :get_business, only: [:new, :create]

  def index
    @reviews = Review.limit(10)
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(create_review, user: current_user, business: @business)

    if @review.save
      flash[:success] = "You just reviewed #{@business.name}!"
      redirect_to @business
    else
      flash[:error] = "Please fill up the rating and review description!"
      redirect_to review_business_path
    end
  end

  private
  def get_business
    @business ||= Business.find(params[:id])
  end

  def create_review
    params.require(:review).permit!
  end
end