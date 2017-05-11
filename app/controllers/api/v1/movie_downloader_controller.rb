class Api::V1::MovieDownloaderController < MoviesController
  before_action  :authenticate_user!
  respond_to     :json

  def get_download_url
    movie = get_movie_from_database
    link = Putio.find_and_download(movie.folder_name)
    set_downloading_status_to_false(movie) if movie_not_found(link)
    respond_with link.gsub('&attachment=1', '')
  end

private

  def movie_not_found(link)
    ((link == { error: 'failed to find video' }) || (link == 'error')) ? false : true
  end

  def set_downloading_status_to_false(movie)
    movie.downloading = false
    movie.save!
  end
end
