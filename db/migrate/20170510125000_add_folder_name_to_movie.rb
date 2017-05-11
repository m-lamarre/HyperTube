class AddFolderNameToMovie < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :folder_name, :string
  end
end
