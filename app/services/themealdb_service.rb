class ThemealdbService
  URL = 'https://www.themealdb.com'

  def random
    response = connection.get('/api/json/v1/1/random.php')
    JSON.parse(response.body)
  end

  private

  def connection
    @connection ||=
      Faraday.new(url: URL) do |faraday|
        faraday.request :url_encoded
        faraday.adapter Faraday.default_adapter
      end
  end
end