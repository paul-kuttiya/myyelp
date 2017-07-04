class BusinessesController < ApplicationController
  before_action :require_user, only: [:new, :create]

  def index
    @businesses = Business.limit(10)
  end

  def show
    @business = Business.find(params[:id])
    @reviews = @business.reviews || []
  end

  def new
    @business = Business.new
  end

  def create
    @business = Business.new(business_params)
    
    if @business.save
      flash[:success] = "Successfully created #{@business.name}!"
      redirect_to @business
    else
      render :new
    end
  end

  private
  def business_params
    params.require(:business).permit!
  end

  def existing_business
  end
end