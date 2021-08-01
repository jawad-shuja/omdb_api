class Review < ApplicationRecord
  include Swagger::Blocks

  swagger_schema :Review do
    key :required, [:id]
    property :id do
      key :type, :string
      key :format, :uuid
    end
    property :rating do
      key :type, :integer
    end
  end

  swagger_schema :ReviewInput do
    property :review do
      property :rating do
        key :type, :integer
      end
    end
  end

  belongs_to :movie
  belongs_to :user

  validates :rating, inclusion: 1..5
end
