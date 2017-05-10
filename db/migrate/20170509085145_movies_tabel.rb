class MoviesTabel < ActiveRecord::Migration[5.0]
  def change
    create_table :movies do |t|
      t.string :title, null: false, default: ''
      t.string :source, null: false, default: ''
      t.string :movie_id, null: false, default: ''
      t.string :quality, null: false, default: ''
      t.string :size, default: '0'

      t.boolean :stored, default: false
      t.text :url, default: ''

      t.datetime :stored_at
      t.timestamps null: false
    end

    add_index :movies, :title, unique: false

    add_index :movies, :source, unique: false
    add_index :movies, :movie_id, unique: false
    add_index :movies, :quality, unique: false
  end
end
