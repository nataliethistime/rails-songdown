class AssociateSetlistWithUser < ActiveRecord::Migration
  def change
    change_table :setlists do |t|
      t.belongs_to :user, :index => true
    end
  end
end
