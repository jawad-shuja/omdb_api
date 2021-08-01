class User < ApplicationRecord
  include Swagger::Blocks

  swagger_schema :User do
    key :required, [:id]
    property :id do
      key :type, :string
      key :format, :uuid
    end
    property :email do
      key :type, :string
    end
  end

  swagger_schema :UserInput do
    property :user do
      property :email do
        key :type, :string
      end
      property :password do
        key :type, :string
      end
    end
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable, :recoverable, :rememberable

  devise :database_authenticatable, :registerable, :validatable,
  :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  enum role: { admin: 1, customer: 2 }
end
