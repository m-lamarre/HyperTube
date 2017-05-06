class MoviesController < HomepagesController
  before_action :authenticate_user!

  def index
    @movies ||= movies_from_yts 20, params[:page]
    @yts_count ||= FakeMovieModel.new((@total_yts_movie_count / 20 || 1), (params[:page] || 1))
  end

  def show
    get_movie_by_source
  end

  def play
  end

private

def get_movie_by_source
  # @movie ||= Movie.find_by(source: params[:source], id: params[:id])
  @movie ||= get_yts_movie_by_id(params[:id]) if params[:source] == 'yts'
  @movie ||= select_random_movies(1).first
end

end
