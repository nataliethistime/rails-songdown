class RemoveDateFromSetlists < ActiveRecord::Migration[5.0]
  def change
    remove_column :setlists, :date
  end
end
