class Putio

  def self.list
    JSON.parse RestClient.get('https://api.put.io/v2/files/list', default_query) rescue { error: 'failed to list files' }
  end

  def self.upload(url)
    query = default_query[:params]
    query[:url] = url
    query[:callback_url] = nil

    JSON.parse RestClient.post('https://api.put.io/v2/transfers/add', query) rescue { error: 'failed to upload' }
  end

  def self.get_file(id)
    JSON.parse RestClient.get("https://api.put.io/v2/files/#{id}", default_query) rescue { error: 'file not found' }
  end

  def self.delete_file(id)
    query = default_query[:params]
    query[:file_ids] = id.to_s

    JSON.parse RestClient.post('https://api.put.io/v2/files/delete', query) rescue { error: 'failed to delete file' }
  end

  def self.get_torrent_status(torrent_id)
    JSON.parse RestClient.get("https://api.put.io/v2/transfers/#{torrent_id}", default_query)
  end

  def self.share(id)
    query = default_query[:params]
    query[:file_ids] = id.to_s
    query[:friends] = 'everyone'

    JSON.parse RestClient.post('https://api.put.io/v2/files/share', query)
  end

  def self.download(id)
    RestClient.get("https://api.put.io/v2/files/#{id}/download", default_query) do |response, request, result, &block|
      if [301, 302, 307].include? response.code
        response.headers[:location]
      else
        { error: 'file not found' }
      end
    end
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
