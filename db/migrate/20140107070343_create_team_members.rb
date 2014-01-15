class CreateTeamMembers < ActiveRecord::Migration
  def change
    create_table :team_members do |t|
      t.string :title, null: false
      t.string :name, null: false
      t.text :description, null: false
      t.string :avatar, null: false

      t.timestamps
    end

    add_index :team_members, :name
  end
end
