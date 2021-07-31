# app/controllers/sessions_controller.rb

class SessionsController < Devise::SessionsController

  private

  def respond_with(resource, _opts = {})
    render_response(resource, UserBlueprint)
  end

  def respond_to_on_destroy
    head :no_content
  end

end
