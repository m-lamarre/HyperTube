class MoviesController < HomepagesController
  before_action :authenticate_user!

  def show
    get_movie_by_source
  end

private
  def get_movie_by_source
    @movie ||= get_yts_movie_by_id(params[:id]) if params[:source] == 'yts'
  end
end
