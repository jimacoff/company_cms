class AddIndexToServicesCreatedAt < ActiveRecord::Migration
  def change
    add_index :services, :created_at
  end
end
