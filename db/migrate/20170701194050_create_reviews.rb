class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :rating, :user_id, :business_id
      t.text :description
      t.timestamps
    end
  end
end
