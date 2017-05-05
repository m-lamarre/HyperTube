class Putio

  def self.list
    RestClient.get('https://api.put.io/v2/files/list', default_query)
  end

  def self.upload(url='https://yts.ag/torrent/download/B1671B938EB021B2B4505ECAD8789C6B4C30624C')
    query = default_query[:params]
    query[:file] = open(url)

    RestClient.post('https://upload.put.io/v2/files/upload', query)
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
