class ChangeIsbnIntegerLimitInBooks < ActiveRecord::Migration[6.0]
  def change
    change_column :books, :ISBN, :integer, limit: 8
  end
end
