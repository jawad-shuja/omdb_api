class Show < ApplicationRecord
  belongs_to :movie

  scope :upcoming, -> { where('show_time > ?', Time.now) }
end
