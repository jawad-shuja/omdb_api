# frozen_string_literal: true

class MovieDatum < ApplicationRecord
  belongs_to :movie, touch: true
end
