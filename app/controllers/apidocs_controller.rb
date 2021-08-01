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

  SWAGGERED_CLASSES = [
    Api::V1::MoviesController,
    Api::V1::ReviewsController,
    Api::V1::ShowsController,
    SessionsController,
    RegistrationsController,
    User,
    Movie,
    Review,
    Show,
    ErrorModel,
    self
  ].freeze

  def index
    render json: Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
  end
end
