class Movie < ApplicationRecord
  include Swagger::Blocks

  swagger_schema :Movie do
    key :required, [:id]
    property :id do
      key :type, :string
      key :format, :uuid
    end
    property :price do
      key :type, :integer
    end
    property :imdbRating do
      key :type, :string
    end
    property :imdbVotes do
      key :type, :string
    end
    property :imdbID do
      key :type, :string
    end
    property :title do
      key :type, :string
    end
    property :year do
      key :type, :string
    end
    property :rated do
      key :type, :string
    end
    property :released do
      key :type, :string
    end
    property :runtime do
      key :type, :string
    end
    property :genre do
      key :type, :string
    end
    property :director do
      key :type, :string
    end
    property :writer do
      key :type, :string
    end
    property :actors do
      key :type, :string
    end
    property :plot do
      key :type, :string
    end
    property :language do
      key :type, :string
    end
    property :country do
      key :type, :string
    end
    property :awards do
      key :type, :string
    end
    property :poster do
      key :type, :string
    end
    property :ratings do
      key :type, :array
      items do
        property :Source do
          key :type, :string
        end
        property :Value do
          key :type, :string
        end
      end
    end
    property :metascore do
      key :type, :string
    end
    property :type do
      key :type, :string
    end
    property :dvd do
      key :type, :string
    end
    property :boxOffice do
      key :type, :string
    end
    property :production do
      key :type, :string
    end
    property :website do
      key :type, :string
    end
    property :shows do
      key :type, :array
      items do
        key :'$ref', :Show
      end
    end
    property :reviews do
      key :type, :array
      items do
        key :'$ref', :Review
      end
    end
  end

  swagger_schema :MovieInput do
    property :movies do
      property :shows do
        key :type, :array
        items do
          property :id do
            key :type, :string
            key :format, :uuid
          end
          property :show_time do
            key :type, :string
            key :format, :datetime
          end
          property :_destroy do
            key :type, :string
          end
        end
      end
      property :price do
        key :type, :integer
      end
    end
  end

  attr_accessor *%i[Title Year Rated Released Runtime Genre Director Writer Actors Plot Language Country Awards Poster Ratings Metascore imdbRating imdbVotes imdbID Type DVD BoxOffice Production Website]

  has_one :movie_datum
  has_many :shows
  has_many :reviews

  validates :price, numericality: { greater_than: 0 }, allow_nil: true

  accepts_nested_attributes_for :shows, allow_destroy: true, reject_if: Proc.new { |attributes| attributes['show_time'].blank? }

  def fetch_details_from_omdb
    omdb = OMDBService.new(self.omdb_reference, self.movie_datum&.last_modified_at)
    response = omdb.fetch
    if response.code == 304
      data = fetch_data
      self.assign_attributes(data.ombd_meta)
    elsif response.code == 200
      data = update_data(response)
      if data.save
        self.assign_attributes(data.ombd_meta)
      else
        data = fetch_data
        self.assign_attributes(data.ombd_meta)
      end
    else
      data = fetch_data
      self.assign_attributes(data.ombd_meta)
    end

    self
  end

  private

  def fetch_data
    Rails.cache.fetch([cache_key, __method__], expires_in: 1.hour) do
      self.movie_datum || {}
    end
  end

  def update_data(response)
    data = movie_datum || build_movie_datum
    data.ombd_meta = sanitize(JSON.parse(response.body, symbolize_names: true))
    data.last_modified_at = response.headers['last-modified']

    return data
  end

  def sanitize(data)
    allowed_keys = %i[Title Year Rated Released Runtime Genre Director Writer Actors Plot Language Country Awards Poster Ratings Metascore imdbRating imdbVotes imdbID Type DVD BoxOffice Production Website]
    data.slice!(*allowed_keys)

    return data
  end
end
