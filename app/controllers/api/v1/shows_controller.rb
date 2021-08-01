# app/controllers/api/v1/shows_controller.rb

class Api::V1::ShowsController < Api::V1::BaseController

  include Swagger::Blocks

  before_action :set_movie, only: %w[index]

  def index
    shows = @movie.shows.upcoming
    render_collection(shows, ShowBlueprint)
  end

  swagger_path '/movies/{movie_id}/shows' do
    operation :get do
      key :summary, 'Upcoming movies shows'
      key :description, 'Returns all upcoming show times for movie with id movie_id'
      key :produces, [
        'application/json',
      ]
      key :tags, [
        'show'
      ]

      parameter do
        key :name, 'Authorization'
        key :in, :header
        key :description, 'Bearer {token}'
        key :required, false
        key :type, :string
      end

      parameter do
        key :name, :movie_id
        key :in, :path
        key :description, 'ID of movie to fetch shows for'
        key :required, true
        key :type, :string
        key :format, :uuid
      end

      response 200 do
        key :description, 'show response'
        schema do
          key :type, :array
          items do
            key :'$ref', :Show
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
    @movie = Movie.find(params[:movie_id])
  end

end
