# app/controllers/api/v1/movies_controller.rb

class Api::V1::MoviesController < Api::V1::BaseController
  include Swagger::Blocks

  before_action :set_movie, only: %w[show update show_times]

  def index
    movies = Movie.includes(:movie_datum)
    movies_with_data = movies.map { |movie| movie.fetch_details_from_omdb }
    render_collection(movies_with_data, MovieBlueprint)
  end

  def show
    movie_with_data = @movie.fetch_details_from_omdb
    render_response(movie_with_data, MovieBlueprint)
  end

  def update
    authorize @movie
    if @movie.update(movie_params)
      movie_with_data = @movie.fetch_details_from_omdb
      render_response(movie_with_data, MovieBlueprint)
    else
      raise ActiveRecord::RecordInvalid, @movie
    end
  end

  swagger_path '/movies/{id}' do
    operation :get do
      key :summary, 'Fetch movie by ID'
      key :description, 'Returns a single movie with details'
      key :operationId, 'fetch_details_from_omdb'
      key :produces, [
        'application/json'
      ]
      key :tags, [
        'movie'
      ]

      parameter do
        key :name, 'Authorization'
        key :in, :header
        key :description, 'Bearer {token}'
        key :required, false
        key :type, :string
      end

      parameter do
        key :name, :id
        key :in, :path
        key :description, 'ID of movie to fetch'
        key :required, true
        key :type, :string
        key :format, :uuid
      end

      response 200 do
        key :description, 'movie response'
        schema do
          key :'$ref', :Movie
        end
      end

      response 401 do
        key :description, 'Unauthorised access'
        schema do
          key :'$ref', :ErrorModel
        end
      end

      response 422 do
        key :description, 'Unprocessable entity'
        schema do
          key :'$ref', :ErrorModel
        end
      end

      response 404 do
        key :description, 'Not found'
        schema do
          key :'$ref', :ErrorModel
        end
      end
    end

    operation :patch do
      key :description, 'Update movie shows or price'
      key :produces, [
        'application/json'
      ]
      key :tags, [
        'movie'
      ]

      parameter do
        key :name, 'Authorization'
        key :in, :header
        key :description, 'Bearer {token}'
        key :required, false
        key :type, :string
      end

      parameter do
        key :name, :id
        key :in, :path
        key :description, 'ID of movie to update'
        key :required, true
        key :type, :string
        key :format, :uuid
      end

      parameter do
        key :name, :movie
        key :in, :body
        key :description, 'Movie to update'
        key :required, true
        schema do
          key :'$ref', :MovieInput
        end
      end

      response 200 do
        key :description, 'Movie response'
        schema do
          key :'$ref', :Movie
        end
      end

      response 401 do
        key :description, 'Unauthorised access'
        schema do
          key :'$ref', :ErrorModel
        end
      end

      response 422 do
        key :description, 'Unprocessable entity'
        schema do
          key :'$ref', :ErrorModel
        end
      end

      response 404 do
        key :description, 'Not found'
        schema do
          key :'$ref', :ErrorModel
        end
      end
    end
  end

  swagger_path '/movies' do
    operation :get do
      key :summary, 'All movies'
      key :description, 'Returns all movies with details'
      key :produces, [
        'application/json'
      ]
      key :tags, [
        'movie'
      ]

      parameter do
        key :name, 'Authorization'
        key :in, :header
        key :description, 'Bearer {token}'
        key :required, false
        key :type, :string
      end

      response 200 do
        key :description, 'movie response'
        schema do
          key :type, :array
          items do
            key :'$ref', :Movie
          end
        end
      end

      response 401 do
        key :description, 'Unauthorised access'
        schema do
          key :'$ref', :ErrorModel
        end
      end

      response 422 do
        key :description, 'Unprocessable entity'
        schema do
          key :'$ref', :ErrorModel
        end
      end

      response 404 do
        key :description, 'Not found'
        schema do
          key :'$ref', :ErrorModel
        end
      end
    end
  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:price, shows_attributes: %i[id show_time _destroy])
  end
end
