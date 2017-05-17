class MoviesController < HomepagesController
  before_action :authenticate_user!

  def index
    @movies ||= (params[:genre] && (params[:genre] != 'All')) ? get_yts_movies_by_genre(params[:genre], 20, params[:page]) : movies_from_yts(20, params[:page])
    @yts_count ||= FakeMovieModel.new((@total_yts_movie_count / 20 || 1), (params[:page] || 1))
    @genres = %i(All Action Adventure Animation Biography Comedy Crime Documentary Drama Family Fantasy Film-Noir History Horror Music Musical Mystery Romance Sci-Fi Sport Thriller War Western)
    watched_movies
  end

  def show
    get_movie_by_source
  end

  def play
    get_movie_from_database
    @comment = Comment.new
    add_movie_to_watch_list(@movie.id)
    store_local_copy_of_movie
  end

  def search
    @search = params[:query]
    @movie = Movie.new
    @yts_movies = search_movies_from_yts(params[:search_query])
    @hypertorrent_movies = search_movies_from_hypertorrnet(params[:search_query])
    watched_movies(@yts_movies)
    watched_movies(@hypertorrent_movies)
  end

  private

  def store_local_copy_of_movie
    return unless (@movie.folder_name.blank? || Putio.list_search(@movie.folder_name).empty?) && !@movie.downloading
    @movie.stored_at = Time.now
    @movie.stored = true
    @movie.downloading = true
    putio_response = Putio.upload(@movie.url)
    redirect_to root_url if putio_response[:error]
    @movie.folder_name = putio_response['transfer']['name'].gsub('[YTS.AG]', '')
    @movie.save!
  end

  def search_database_movies
    @movies = Movie.where(
      "title LIKE '%#{params[:title]}%'"
    ).where(
      "title LIKE '%#{params[:source]}%'"
    ).where(
      "title LIKE '%#{params[:movie_id]}%'"
    ).where(
      "title LIKE '%#{params[:quality]}%'"
    ).limit(20).offset(params[:page])
  end

  def add_movie_to_watch_list(id)
    current_user.movie_ids += [id]
    current_user.save
  end

  def get_movie_by_source
    @movie ||= get_yts_movie_by_id(params[:id]) if params[:source] == 'yts'
    @movie ||= get_hypertorrnet_movie_by_id(params[:id]) if params[:source] == 'hypertorrent'
    @movie ||= select_random_movies(1).first
  end

  def find_and_save_movie
    movie_from_source = get_yts_movie_by_id(params[:id]) if params[:source] == 'yts'
    movie_from_source ||= get_hypertorrnet_movie_by_id(params[:id]) if params[:source] == 'hypertorrent'
    movie = save_movie_to_database(movie_from_source)
  end

  def save_movie_to_database(movie_from_source)
    torrent = movie_from_source[:torrents].select { |m| m[:quality] == params[:quality] }.first

    Movie.create(
      title: movie_from_source[:title],
      source: movie_from_source[:source],
      movie_id: movie_from_source[:id],
      quality: params[:quality],
      thumbnail: movie_from_source[:image_url],
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

  def watched_movies(current_movies = @movies)
    watched = current_user.movies
    current_movies.map! do |m|
      m[:watched] = !(watched.select { |movie|  m[:id].to_s == movie.movie_id.to_s && movie.source == m[:source] }.blank?)
      m
    end
  end
end
