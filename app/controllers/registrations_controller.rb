# app/controllers/registrations_controller.rb

class RegistrationsController < Devise::RegistrationsController
  include Swagger::Blocks

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

  def create
    build_resource(sign_up_params)
    resource.save
    sign_up(resource_name, resource) if resource.persisted?

    render_response(resource, UserBlueprint)
  end
end
