# frozen_string_literal: true

class ApidocsController < ActionController::API
  include Swagger::Blocks

  swagger_root do
    key :swagger, '2.0'
    info do
      key :version, '1.0.0'
      key :title, 'Swagger Movies API'
      key :description, 'An API for OMDB movies'
      contact do
        key :name, 'Jawad'
      end
      license do
        key :name, 'MIT'
      end
    end
    key :host, 'localhost:3000'
    key :basePath, '/api'
    key :consumes, ['application/json']
    key :produces, ['application/json']
  end

  swagger_schema :UserInput do
    property :user do
      property :email do
        key :type, :string
      end
      property :password do
        key :type, :string
      end
    end
  end

  swagger_schema :User do
    key :required, [:id]
    property :id do
      key :type, :string
      key :format, :uuid
    end
    property :email do
      key :type, :string
    end
  end

  swagger_schema :Show do
    key :required, [:id]
    property :id do
      key :type, :string
      key :format, :uuid
    end
    property :show_time do
      key :type, :string
      key :format, :datetime
    end
  end

  swagger_schema :ReviewInput do
    property :review do
      property :rating do
        key :type, :integer
      end
    end
  end

  swagger_schema :Review do
    key :required, [:id]
    property :id do
      key :type, :string
      key :format, :uuid
    end
    property :rating do
      key :type, :integer
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

  swagger_schema :ErrorModel do
    key :required, %i[status messages]
    property :staus do
      key :type, :string
    end
    property :messages do
      key :type, :array
      items do
        key :type, :string
      end
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

  swagger_path '/movies/{movie_id}/reviews' do
    operation :post do
      key :description, 'Create review for movie with movie_id'
      key :produces, [
        'application/json'
      ]
      key :tags, [
        'review'
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
        key :description, 'ID of movie to update'
        key :required, true
        key :type, :string
        key :format, :uuid
      end

      parameter do
        key :name, :review
        key :in, :body
        key :description, 'Review to create'
        key :required, true
        schema do
          key :'$ref', :ReviewInput
        end
      end

      response 200 do
        key :description, 'Review response'
        schema do
          key :'$ref', :Review
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

  swagger_path '/movies/{movie_id}/shows' do
    operation :get do
      key :summary, 'Upcoming movies shows'
      key :description, 'Returns all upcoming show times for movie with id movie_id'
      key :produces, [
        'application/json'
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

  swagger_path '/api/signup' do
    operation :post do
      key :description, 'Sign up'
      key :produces, [
        'application/json'
      ]
      key :tags, [
        'user'
      ]

      parameter do
        key :name, :user
        key :in, :body
        key :description, 'User to register'
        key :required, true
        schema do
          key :'$ref', :UserInput
        end
      end

      response 200 do
        key :description, 'User response'
        schema do
          key :'$ref', :User
        end
      end
    end
  end

  swagger_path '/api/login' do
    operation :post do
      key :description, 'Sign in'
      key :produces, [
        'application/json'
      ]
      key :tags, [
        'user'
      ]

      parameter do
        key :name, :user
        key :in, :body
        key :description, 'User to sign in'
        key :required, true
        schema do
          key :'$ref', :UserInput
        end
      end

      response 200 do
        key :description, 'User response'
        schema do
          key :'$ref', :User
        end
      end
    end
  end

  SWAGGERED_CLASSES = [
    self
  ].freeze

  def index
    render json: Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
  end
end
