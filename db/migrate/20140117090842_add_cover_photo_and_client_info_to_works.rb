class AddCoverPhotoAndClientInfoToWorks < ActiveRecord::Migration
  def change
    add_column :works, :cover_photo, :string
    add_column :works, :link, :string
    add_column :works, :client_info, :string
    add_column :works, :client_quote, :text
    rename_column :works, :client, :client_name
  end
end
