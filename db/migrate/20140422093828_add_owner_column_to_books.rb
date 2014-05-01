class AddOwnerColumnToBooks < ActiveRecord::Migration
  def change
    add_column :books, :owner, :integer, null: false, after: :isbn
    add_index :books, :owner, unique: false
  end
end
