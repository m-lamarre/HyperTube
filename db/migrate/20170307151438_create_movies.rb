class CreateMovies < ActiveRecord::Migration[5.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :year
      t.text :synopsis

      t.timestamps null: false 
    end
  end
end
