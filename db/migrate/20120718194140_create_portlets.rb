class CreatePortlets < ActiveRecord::Migration
  def change
    create_table :portlets do |t|
      t.integer :metric_id
      t.integer :portal_id
      t.integer :order

      t.timestamps
    end
  end
end
