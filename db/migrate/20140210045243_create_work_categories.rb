class CreateWorkCategories < ActiveRecord::Migration
  def change
    create_table :work_categories do |t|
      t.string :name, null: false
      t.text :description

      t.timestamps
    end

    add_index :work_categories, :name, unique: true
  end
end
