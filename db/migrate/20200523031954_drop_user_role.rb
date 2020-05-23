class DropUserRole < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :role
  end
end
