require 'rails_helper'
RSpec.describe Api::V1::RegistrationsController, type: :request do
  describe 'signing up' do
    it "returns a JSON when valid sign up" do
      post '/api/v1/sign_up', :params => {'email' => 'test@test.com', 'password' => 'testpassword', 'password_confirmation' => 'testpassword'}
      expect(JSON.parse(response.body)).to include "email" => "test@test.com"
    end
  end

  describe 'signing in' do
    it "returns a JSON when valid sign in" do
      post '/api/v1/sign_up', :params => {'email' => 'test@test.com', 'password' => 'testpassword', 'password_confirmation' => 'testpassword'}
      expect(JSON.parse(response.body)).to include "email" => "test@test.com"
    end
  end
end
