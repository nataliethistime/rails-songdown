class CreateSetlists < ActiveRecord::Migration
  def change
    create_table :setlists do |t|

      t.timestamps null: false

      t.string :title
      t.date :date
      t.text :notes

    end
  end
end
