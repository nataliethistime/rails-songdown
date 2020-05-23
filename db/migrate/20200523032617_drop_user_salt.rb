class DropUserSalt < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :salt
  end
end
