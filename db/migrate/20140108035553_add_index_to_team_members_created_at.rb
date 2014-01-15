class AddIndexToTeamMembersCreatedAt < ActiveRecord::Migration
  def change
    add_index :team_members, :created_at
  end
end
