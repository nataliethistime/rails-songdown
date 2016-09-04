class AddFullNameToSong < ActiveRecord::Migration
  def change
    change_table :songs do |t|
      t.string :full_name
    end
  end
end
