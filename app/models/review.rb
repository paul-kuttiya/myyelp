class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :business

  default_scope { order('created_at DESC') }

  def user_name
    self.user.first_name
  end

  def business_name
    self.business.name
  end
end