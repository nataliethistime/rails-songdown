class SetlistAssociationSetup < ActiveRecord::Migration
  def change
    change_table :setlist_items do |t|
      t.belongs_to :setlist, :index => true
    end
  end
end
