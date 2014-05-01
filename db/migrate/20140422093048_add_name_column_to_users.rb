class AddNameColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string, null: false, after: :id
    add_index :users, :name, unique: true
  end
end
