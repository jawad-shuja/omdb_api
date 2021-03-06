# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  validates :rating, inclusion: 1..5
  default_scope { order(created_at: :desc) }
end
