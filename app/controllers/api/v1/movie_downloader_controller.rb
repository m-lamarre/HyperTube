class Api::V1::MovieDownloaderController < MoviesController
  before_action  :authenticate_user!
  respond_to     :json

  def get_download_url
    movie = get_movie_from_database
    puts Putio.find_and_download(movie.folder_name)
    respond_with 'error'
  end
end
