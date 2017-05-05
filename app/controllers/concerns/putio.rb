class Putio

  def self.list
    JSON.parse RestClient.get('https://api.put.io/v2/files/list', default_query) rescue { error: 'failed to list files' }
  end

  def self.upload(url='https://yts.ag/torrent/download/B1671B938EB021B2B4505ECAD8789C6B4C30624C')
    query = default_query[:params]
    query[:file] = open(url)

    JSON.parse RestClient.post('https://upload.put.io/v2/files/upload', query) rescue { error: 'failed to upload' }
  end

  def self.get_file_by_id id
    JSON.parse RestClient.get("https://api.put.io/v2/files/#{id}", default_query) rescue { error: 'file not found' }
  end

  def self.delete_file_by_id id
    query = default_query[:params]
    query[:file_ids] = id.to_s

    JSON.parse RestClient.post("https://api.put.io/v2/files/delete", query) rescue { error: 'failed to delete file' }
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
