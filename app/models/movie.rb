# frozen_string_literal: true

class Movie < ApplicationRecord
  attr_accessor(*%i[Title Year Rated Released Runtime Genre Director Writer Actors Plot Language Country Awards Poster
                    Ratings Metascore imdbRating imdbVotes imdbID Type DVD BoxOffice Production Website])

  has_one :movie_datum
  has_many :shows
  has_many :reviews

  validates :price, numericality: { greater_than: 0 }, allow_nil: true

  accepts_nested_attributes_for :shows, allow_destroy: true, reject_if: proc { |attributes|
                                                                          attributes['show_time'].blank?
                                                                        }

  def fetch_details_from_omdb
    omdb = OmdbService.new(omdb_reference, movie_datum&.last_modified_at)
    response = omdb.fetch
    case response.code
    when 304
      data = fetch_data
    when 200
      data = update_data(response)
      if data.save
      else
        data = fetch_data
      end
    else
      data = fetch_data
    end
    assign_attributes(data.ombd_meta)

    self
  end

  private

  def fetch_data
    Rails.cache.fetch([cache_key, __method__], expires_in: 1.hour) do
      movie_datum || {}
    end
  end

  def update_data(response)
    data = movie_datum || build_movie_datum
    data.ombd_meta = sanitize(JSON.parse(response.body, symbolize_names: true))
    data.last_modified_at = response.headers['last-modified']

    data
  end

  def sanitize(data)
    allowed_keys = %i[Title Year Rated Released Runtime Genre Director Writer Actors Plot Language Country Awards
                      Poster Ratings Metascore imdbRating imdbVotes imdbID Type DVD BoxOffice Production Website]
    data.slice!(*allowed_keys)

    data
  end
end
