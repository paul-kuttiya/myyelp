class ReviewsController < ApplicationController
  before_action :require_user, only: [:new, :create, :edit, :update]
  before_action :get_business, only: [:new, :create, :edit, :update]

  def index
    @reviews = Review.limit(10)
  end

  def new
    @review = Review.new()
  end

  def create
    review_attr = review_params.merge(user: current_user, business: @business)
    @review = Review.new(review_attr)

    if @review.save
      flash[:success] = "You just reviewed #{@business.name}!"
      redirect_to @business
    else
      flash[:danger] = "Please fill up the rating and review description!"
      redirect_to new_business_review_path
    end
  end

  def edit
    @review = Review.find_by(id: params[:id])
  end

  def update
    @review = Review.find(params[:id])

    if @review.update_attributes(review_params)
      redirect_to @business
    else
      flash[:danger] = "Please fill up the rating and review description!"
      redirect_to edit_business_review_path(@business, @review)
    end
  end

  private
  def get_business
    @business = Business.find(params[:business_id])
  end

  def review_params
    params.require(:review).permit!
  end
end