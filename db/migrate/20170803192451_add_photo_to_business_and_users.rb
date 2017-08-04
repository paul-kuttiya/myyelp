class AddPhotoToBusinessAndUsers < ActiveRecord::Migration
  def change
    add_column :users, :photo, :string
    add_column :businesses, :photo, :string    
  end
end
