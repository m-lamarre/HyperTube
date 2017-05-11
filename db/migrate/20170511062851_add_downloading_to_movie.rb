class AddDownloadingToMovie < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :downloading, :boolean, default: false
    add_index  :movies, :downloading
  end
end
