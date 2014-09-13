class CreateBusinessConnections < ActiveRecord::Migration
  def change
    create_table :business_connections do |t|

      t.timestamps
    end
  end
end
