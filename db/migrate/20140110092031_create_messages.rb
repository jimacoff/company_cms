class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :email, null: false
      t.string :name
      t.string :subject
      t.text :message, null: false

      t.timestamps
    end

    add_index :messages, :email
  end
end
