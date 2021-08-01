# frozen_string_literal: true

# app/blueprints/user_blueprint.rb

class UserBlueprint < Blueprinter::Base
  identifier :id

  fields :email
end
