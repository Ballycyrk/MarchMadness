class AddIndexOnHandleAndEmail < ActiveRecord::Migration

  def change
    add_index :users, :handle, unique: true
    add_index :users, :email, unique: true
  end
end
