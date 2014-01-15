class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.string :image, null: false

      t.timestamps

    end

    add_index :services, :name, unique: true
  end
end
