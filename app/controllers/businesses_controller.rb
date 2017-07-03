class BusinessesController < ApplicationController
  def index
    @businesses = Business.limit(10)
  end

  def show
    @business = Business.find(params[:id])
    @reviews = @business.reviews || []
  end
end