class AddCityWorkWebsiteAboutFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :city, :string
    add_column :users, :work, :text
    add_column :users, :website, :string
    add_column :users, :about, :text
  end
end
