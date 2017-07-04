class BusinessesController < ApplicationController
  before_action :require_user, only: [:new]

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
    @business = Business.new()
  end

  private
  def business_params
    params.require(:business).permit!
  end
end