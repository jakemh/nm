class AddLocatableTypeAndLocatableIdColsToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :locatable_type, :string
    add_column :locations, :locatable_id, :integer
  end
end
