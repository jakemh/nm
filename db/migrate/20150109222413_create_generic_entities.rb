class CreateGenericEntities < ActiveRecord::Migration
  def change
    create_table :generic_entities do |t|

      t.timestamps
    end
  end
end
