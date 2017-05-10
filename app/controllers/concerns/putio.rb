class Putio

  def self.list(id = ENV['PUTIO_DIR_ID'])
    query = default_query
    query[:params][:parent_id] = id

    JSON.parse RestClient.get('https://api.put.io/v2/files/list', query) rescue { error: 'failed to list files' }
  end

  def self.upload(url)
    query = default_query[:params]
    query[:url] = url
    query[:save_parent_id] = ENV['PUTIO_DIR_ID']

    JSON.parse RestClient.post('https://api.put.io/v2/transfers/add', query) rescue { error: 'failed to upload' }
  end

  def self.get_file(id)
    JSON.parse RestClient.get("https://api.put.io/v2/files/#{id}", default_query) rescue { error: 'file not found' }
  end

  def self.delete(id)
    query = default_query[:params]
    query[:file_ids] = id.to_s

    JSON.parse RestClient.post('https://api.put.io/v2/files/delete', query) rescue { error: 'failed to delete file' }
  end

  def self.get_torrent_status(torrent_id)
    JSON.parse RestClient.get("https://api.put.io/v2/transfers/#{torrent_id}", default_query) rescue { error: 'failed to get torrent' }
  end

  def self.share(id)
    query = default_query[:params]
    query[:file_ids] = id.to_s
    query[:friends] = 'everyone'

    JSON.parse RestClient.post('https://api.put.io/v2/files/share', query) rescue { error: 'failed to share item' }
  end

  def self.download(id)
    RestClient.get("https://api.put.io/v2/files/#{id}/download", default_query) do |response, request, result, &block|
      if [301, 302, 307].include? response.code
        response.headers[:location]
      else
        { error: 'file not found' }
      end
    end rescue { error: 'file not found.' }
  end

  def self.find_id_of_movie_in_folder(id)
    response = self.list(id)

    # searches for videos, sorts them from biggest to smallest, and selects the id of the first one
    response['files'].select { |file| file['file_type'] == 'VIDEO' }.sort_by { |file| -file['size'] }.first['id'] rescue { error: 'failed to find video' }
  end

  def self.search(search_query, query_type = 'FOLDER')
    return { 'files' => [] } if search_query == nil
    query = default_query
    query[:params][:query] = search_query
    query[:params][:type] = query_type

    JSON.parse RestClient.get('https://api.put.io/v2/files/search/' , query) rescue { error: 'failed to search for the item' }
  end

  def self.find_and_download(name)
    id = self.search(name)['files'].select { |result| result['file_type'] == 'VIDEO' }.sort_by { |file| -file['size'] }.first['id'] rescue { error: 'failed to find video' }
    self.download(id)
  end

  private

  def self.default_query
    {
      params: {
        oauth_token: ENV['PUTIO_TOKEN'],
        parent_id:   ENV['PUTIO_DIR_ID']
      }
    }
  end
end
