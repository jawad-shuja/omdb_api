# frozen_string_literal: true

class OmdbService
  include HTTParty
  base_uri 'www.omdbapi.com'

  def initialize(id, last_modified_at = nil)
    headers = {}
    headers['If-Modified-Since'] = last_modified_at.httpdate if last_modified_at.present?

    @options = {
      query: {
        apikey: ENV['OMDB_API_KEY'],
        i: id
      },
      headers: headers
    }
  end

  def fetch
    self.class.get('', @options)
  end
end
