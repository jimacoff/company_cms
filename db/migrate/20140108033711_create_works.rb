class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.string :name, null: false
      t.string :client, null: false
      t.text :story, null: false
      t.string :techs, null: false

      t.timestamps
    end

    add_index :works, :name
  end
end
