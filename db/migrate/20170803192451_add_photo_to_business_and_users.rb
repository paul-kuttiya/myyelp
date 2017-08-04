class AddPhotoToBusinessAndUsers < ActiveRecord::Migration
  def change
    add_column :users, :photo, :string, default: "/images/profile-placeholder.png"
    add_column :businesses, :photo, :string, default: "/images/profile-placeholder.png"    
  end
end
