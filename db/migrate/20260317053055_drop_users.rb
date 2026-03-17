class DropUsers < ActiveRecord::Migration[8.0]
  def change
    drop_table :users if table_exists?(:users)
  end
end
