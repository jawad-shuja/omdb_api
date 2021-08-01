# spec/support/user_helpers.rb

require 'faker'
require 'factory_bot_rails'

module UserHelpers

  def create_user
    FactoryBot.create(
      :user,
      email: Faker::Internet.email,
      password: Faker::Internet.password
    )
  end

  def build_user
    FactoryBot.build(
      :user,
      email: Faker::Internet.email,
      password: Faker::Internet.password
    )
  end

  def create_admin
    FactoryBot.create(
      :user,
      email: Faker::Internet.email,
      password: Faker::Internet.password,
      role: User::roles[:admin]
    )
  end

  def build_admin
    FactoryBot.build(
      :user,
      email: Faker::Internet.email,
      password: Faker::Internet.password,
      role: User::roles[:admin]
    )
  end

end
