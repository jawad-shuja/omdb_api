class OMDBService

  include HTTParty
  base_uri 'www.omdbapi.com'

  def initialize(id, last_modified_at=nil)
    headers = Hash.new
    headers['If-Modified-Since'] = last_modified_at.httpdate if last_modified_at.present?

    @options = {
      query: {
        apikey: Rails.application.credentials[:omdb_api_key],
        i: id
      },
      headers: headers
    }
  end

  def fetch
    self.class.get("", @options)
  end

end
