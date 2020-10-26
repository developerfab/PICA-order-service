class AddCreditNumberCardToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :credit_number_card, :string
  end
end
