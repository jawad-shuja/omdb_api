class MovieDatum < ApplicationRecord
  belongs_to :movie, touch: true
end
