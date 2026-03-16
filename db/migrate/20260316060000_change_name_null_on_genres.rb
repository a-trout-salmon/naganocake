class ChangeNameNullOnGenres < ActiveRecord::Migration[8.0]
  def up
    change_column_null :genres, :name, false
  end

  def down
    change_column_null :genres, :name, true
  end
end
