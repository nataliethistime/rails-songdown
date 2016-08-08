class SongsAdjustments < ActiveRecord::Migration
  def change
    change_table :songs do |t|
      t.rename :name, :title
      t.integer :views
    end
  end
end
