class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :website
      t.string :address
      t.string :city
      t.string :state
      t.integer :zip
      t.string :business_type
      t.string :industry
      t.text :description

      t.timestamps
    end
  end
end
