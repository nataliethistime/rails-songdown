class AddRoleToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :role, :default => 'user'
    end
  end
end
