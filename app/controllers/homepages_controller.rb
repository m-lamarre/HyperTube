class HomepagesController < ApplicationController
  include RandomFunctions
  include YtsApi

  @random_movies

  def index
    @random_movies ||= select_random_movies
  end

private

  def select_random_movies(amount_of_elements = 3, range_end = 100, range_start = 0)
    selected_movies_indexes = generate_array_of_unique_ids(amount_of_elements, range_end, range_start)
    selected_movies = []
    selected_movies_indexes.each { |index| selected_movies << movies_from_yts(1, index).first }
    selected_movies
  end
end
