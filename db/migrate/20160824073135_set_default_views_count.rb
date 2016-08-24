class SetDefaultViewsCount < ActiveRecord::Migration
  def change
    change_column :songs, :views, :integer, :default => 0
  end
end
