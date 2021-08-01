# app/controllers/sessions_controller.rb

class SessionsController < Devise::SessionsController
  include Swagger::Blocks

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

  private

  def respond_with(resource, _opts = {})
    render_response(resource, UserBlueprint)
  end

  def respond_to_on_destroy
    head :no_content
  end
end
