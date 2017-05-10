class Movie < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :users, through: :watched_movies
  has_many :watched_movies, dependent: :destroy
end
