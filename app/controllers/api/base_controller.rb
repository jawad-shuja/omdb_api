# app/controllers/api/base_controller.rb
class Api::BaseController < ApplicationController

  before_action :authenticate_user!

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::RecordInvalid, with: :not_valid

  private

  def not_found
    render json: {
      status: 'failed',
      messages: [
        'Not found'
      ]
    }, status: 404
  end

  def not_valid(resource)
    render json: {
      status: 'failed',
      messages: [
        resource.errors&.full_messages || 'Not valid'
      ]
    }, status: 422
  end

end
