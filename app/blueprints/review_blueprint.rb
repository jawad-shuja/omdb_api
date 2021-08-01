# frozen_string_literal: true

# app/blueprints/review_blueprint.rb

class ReviewBlueprint < Blueprinter::Base
  identifier :id

  field :rating
end
