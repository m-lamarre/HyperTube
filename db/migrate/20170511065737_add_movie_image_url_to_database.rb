class AddMovieImageUrlToDatabase < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :thumbnail, :text, default: ''
  end
end
