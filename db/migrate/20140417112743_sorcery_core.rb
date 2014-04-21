class SorceryCore < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email,            :null => false
      t.string :crypted_password, :null => false
      t.string :salt,             :null => false
      t.string :auth_token,       :null => true

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :auth_token, unique: true
  end
end
