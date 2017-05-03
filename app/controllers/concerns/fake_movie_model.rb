class FakeMovieModel
  attr_accessor :total_pages
  attr_accessor :current_page

  def initialize(pages = 1, current_page = 1)
    @total_pages = pages.to_i
    @current_page = current_page.to_i
  end
end
