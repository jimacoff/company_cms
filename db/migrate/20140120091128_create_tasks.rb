class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.belongs_to :work

      t.timestamps
    end

    add_index :tasks, :title
  end
end
