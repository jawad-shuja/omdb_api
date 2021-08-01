class Show < ApplicationRecord
  include Swagger::Blocks

  swagger_schema :Show do
    key :required, [:id]
    property :id do
      key :type, :string
      key :format, :uuid
    end
    property :show_time do
      key :type, :string
      key :format, :datetime
    end
  end

  belongs_to :movie

  scope :upcoming, -> { where('show_time > ?', Time.now) }
end
