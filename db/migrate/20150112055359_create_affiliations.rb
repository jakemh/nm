class CreateAffiliations < ActiveRecord::Migration
  def change
    create_table :affiliations do |t|
      t.integer :branch_id
      t.integer :user_id

      t.timestamps
    end
  end
end
