# app/controllers/api/v1/reviews_controller.rb

class Api::V1::ReviewsController < Api::V1::BaseController
  include Swagger::Blocks

  before_action :set_movie, only: %w[create]

  def create
    review = @movie.reviews.build(review_params)
    review.user = current_user

    if review.save!
      render_response(review, ReviewBlueprint)
    else
      raise ActiveRecord::RecordInvalid, review
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

  private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def review_params
    params.require(:review).permit(:rating)
  end
end
