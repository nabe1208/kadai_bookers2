class AddColumnToUsers < ActiveRecord::Migration[6.1]
  # テスト後追記
  def change
    add_index :users, :name, unique: true
  end
end
