class AddFullNameSearchableToSong < ActiveRecord::Migration
  def change
    change_table :songs do |t|
      t.string :full_name_searchable
    end
  end
end
