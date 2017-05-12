# This module has been made to use v2 of the YTS api
module YtsApi
  include HTTParty

  @total_yts_movie_count ||= 0

private

  def serialize_yts_torrent(torrent)
    t = Hash.new ''
    t[:url] = torrent['url']
    t[:hash] = torrent['hash']
    t[:quality] = torrent['quality']
    t[:size] = torrent['size_bytes']
    t[:seeds] = torrent['seeds']
    t[:peers] = torrent['peers']
    t
  end

  def serialize_yts_movie(movie)
    m = Hash.new ''
    m[:title] = movie['title']
    m[:id] = movie['id']
    m[:source] = 'yts'
    m[:year] = movie['year']
    m[:rating] = movie['rating']
    m[:runtime] = movie['runtime']
    m[:genres] = movie['genres']
    m[:description] = movie['description_full']
    m[:image_url] = movie['medium_cover_image']
    m[:torrents] = movie['torrents'].map { |torrent| serialize_yts_torrent(torrent) }
    m
  end

  def serialize_yts_movies(movies)
    movies.map { |movie| serialize_yts_movie(movie) }.compact rescue []
  end

  def get_yts_movie_by_id(id = 0)
    api_data = HTTParty.get("https://yts.ag/api/v2/movie_details.json?movie_id=#{id}")
    api_data['status'] == 'ok' ? serialize_yts_movie(api_data['data']['movie']) : api_data['status_message']
  end

  def movies_from_yts(amount = 20, page = 1, sort_by = 'date_added', order_by = 'desc')
    api_data = HTTParty.get(
      "https://yts.ag/api/v2/list_movies.json?limit=#{amount}&page=#{page}&sort_by=#{sort_by}&order_by=#{order_by}"
    )
    if api_data['status'] == 'ok'
      @total_yts_movie_count = api_data['data']['movie_count']
      serialize_yts_movies(api_data['data']['movies'])
    else
      api_data['status_message']
    end
  end

  def search_movies_from_yts(query_term, sort_by = 'date_added', order_by = 'desc', amount = 20, page = 1)
    api_data = HTTParty.get(
      "https://yts.ag/api/v2/list_movies.json?limit=#{amount}&query_term=#{query_term}&sort_by=#{sort_by}&order_by=#{order_by}"
    )
    if api_data['status'] == 'ok'
      @total_yts_movie_count = api_data['data']['movie_count']
      serialize_yts_movies(api_data['data']['movies'])
    else
      api_data['status_message']
    end
  end
end
