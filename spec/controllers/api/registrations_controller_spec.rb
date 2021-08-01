# frozen_string_literal: true

# spec/controllers/api/registrations_controller_spec.rb

require 'rails_helper'

describe RegistrationsController, type: :request do
  let(:user) { build_user }
  let(:existing_user) { create_user }
  let(:signup_url) { '/api/signup' }

  context 'When creating a new user' do
    before do
      post signup_url, params: {
        user: {
          email: user.email,
          password: user.password
        }
      }
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end

    it 'returns a token' do
      expect(response.headers['Authorization']).to be_present
    end

    it 'returns the user email' do
      expect(json).to include('email' => user.email)
    end
  end

  context 'When an email already exists' do
    before do
      post signup_url, params: {
        user: {
          email: existing_user.email,
          password: existing_user.password
        }
      }
    end

    it 'returns 422' do
      expect(response.status).to eq(422)
    end

    it 'returns the error message' do
      expect(json).to include('messages' => [
                                'Email has already been taken'
                              ])
    end
  end
end
