class MoviesController < ApplicationController
  include YtsApi
  include RandomFunctions

  @random_movies

  def index
    @random_movies ||= select_random_movies
  end
end
