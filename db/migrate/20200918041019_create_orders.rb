class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.integer :client_id
      t.decimal :total
      t.string :status
      t.string :comments

      t.timestamps
    end
  end
end
