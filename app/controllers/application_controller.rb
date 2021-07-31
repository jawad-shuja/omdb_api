# app/controllers/application_controller.rb

class ApplicationController < ActionController::API

  def render_response(resource, blueprint)
    if resource.errors.empty?
      render blueprint.render(resource)
    else
      render json: {
        status: "failed",
        messages: resource.errors.full_messages
      }, status: 422
    end
  end

end
