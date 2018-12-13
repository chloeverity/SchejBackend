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
      post '/api/v1/sign_in', :params => {'email' => 'test@test.com', 'password' => 'testpassword', 'password_confirmation' => 'testpassword'}
      expect(JSON.parse(response.body)).to include "email" => "test@test.com"
    end
  end

  describe 'signing out' do
    it "signs out" do
      post '/api/v1/sign_up', :params => {'email' => 'test@test.com', 'password' => 'testpassword', 'password_confirmation' => 'testpassword'}
      post '/api/v1/sign_in', :params => {'email' => 'test@test.com', 'password' => 'testpassword', 'password_confirmation' => 'testpassword'}
      delete '/api/v1/sign_out'
      expect(response.body).to eq ""
    end
  end
end
