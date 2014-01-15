class AddImageableToImages < ActiveRecord::Migration
  def change
    change_table :images do |t|
      t.references :imageable, polymorphic: true
    end

    add_index :images, :imageable_id
  end
end
