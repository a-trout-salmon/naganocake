class AddPostageToOrders < ActiveRecord::Migration[8.0]
  def change
    add_column :orders, :postage, :integer
  end
end
