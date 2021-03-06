# frozen_string_literal: true

# app/controllers/application_controller.rb

class ApplicationController < ActionController::API
  include Pundit

  def render_collection(collection, blueprint)
    render json: blueprint.render_as_json(collection)
  end

  def render_response(resource, blueprint)
    if resource.errors.empty?
      render json: blueprint.render_as_json(resource)
    else
      render json: {
        status: 'failed',
        messages: resource.errors.full_messages
      }, status: 422
    end
  end
end
