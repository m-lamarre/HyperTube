class MoviesController < HomepagesController
  before_action :authenticate_user!

  def index
    @movies ||= movies_from_yts 20, params[:page]
    @yts_count ||= FakeMovieModel.new((@total_yts_movie_count / 20 || 1), (params[:page] || 1))
    watched_movies
  end

  def show
    get_movie_by_source
  end

  def play
    get_movie_from_database
    add_movie_to_watch_list(@movie.id)
    if Putio.search(@movie.title)['files'].empty?
      @movie.stored_at = Time.now
      @movie.stored = true
      Putio.upload(@movie.url)
      @movie.save!
    end
  end

private

  def add_movie_to_watch_list(id)
    current_user.movie_ids += [id]
    current_user.save
  end

  def get_movie_by_source
    @movie ||= get_yts_movie_by_id(params[:id]) if params[:source] == 'yts'
    @movie ||= select_random_movies(1).first
  end

  def find_and_save_movie
    movie_from_source = get_yts_movie_by_id(params[:id]) if params[:source] == 'yts'
    movie = save_movie_to_database(movie_from_source)
  end

  def save_movie_to_database(movie_from_source)
    torrent = movie_from_source[:torrents].select { |m| m[:quality] == params[:quality] }.first

    Movie.create(
      title: movie_from_source[:title],
      source: movie_from_source[:source],
      movie_id: movie_from_source[:id],
      quality: params[:quality],
      size: torrent[:size],
      url: torrent[:url],
      stored: false,
      stored_at: 0
    )
  end

  def get_movie_from_database
    @movie = Movie.find_by(source: params[:source], movie_id: params[:id], quality: params[:quality])
    @movie ||= find_and_save_movie
  end

  def watched_movies
    watched = current_user.movies
    @movies.map! do |m|
    	m[:watched] = !(watched.select { |movie|  m[:id].to_s == movie.movie_id.to_s && movie.source == m[:source] }.blank?)
    	m
    end
  end
end
