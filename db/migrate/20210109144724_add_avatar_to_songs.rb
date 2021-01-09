class AddAvatarToSongs < ActiveRecord::Migration[5.2]
  def change
    add_column :songs, :avatar, :string
  end
end
