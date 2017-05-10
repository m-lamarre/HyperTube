class Movie < ApplicationRecord
  has_many :watched_movies, dependent: :destroy
  has_many :users, through: :watched_movies
end
