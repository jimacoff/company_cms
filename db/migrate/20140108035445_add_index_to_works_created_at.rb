class AddIndexToWorksCreatedAt < ActiveRecord::Migration
  def change
    add_index :works, :created_at
  end
end
