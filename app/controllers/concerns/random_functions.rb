module RandomFunctions

private

  def random_range(range_start, range_end)
    range_start + rand(range_end)
  end

  def generate_array_of_unique_ids(amount_of_elements = 3, range_end = 100, range_start = 1)
    return [] if (range_end - range_start) < amount_of_elements || range_start >= range_end
    movies = []
    movies << random_range(range_start, range_end) until movies.uniq.count == amount_of_elements
    movies
  end
end
