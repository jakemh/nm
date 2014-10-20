class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.decimal :longitude
      t.decimal :latitude

      t.timestamps
    end
  end
end
