# frozen_string_literal: true

# app/controllers/api/v1/base_controller.rb
module Api
  module V1
    # API Base Controller
    class BaseController < ApplicationController
      before_action :authenticate_user!

      rescue_from ActiveRecord::RecordNotFound, with: :not_found
      rescue_from ActiveRecord::RecordInvalid, with: :not_valid
      rescue_from Pundit::NotAuthorizedError, with: :not_authorised

      private

      def not_found
        render json: {
          status: 'failed',
          messages: [
            'Not found'
          ]
        }, status: 404
      end

      def not_valid(error)
        render json: {
          status: 'failed',
          messages: [
            error&.message || 'Not valid'
          ]
        }, status: 422
      end

      def not_authorised
        render json: {
          status: 'failed',
          messages: [
            'Not authorised'
          ]
        }, status: 401
      end
    end
  end
end
