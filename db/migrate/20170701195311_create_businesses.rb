class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string :name, :address, :city, :state, :zip, :phone
      t.timestamps
    end
  end
end
