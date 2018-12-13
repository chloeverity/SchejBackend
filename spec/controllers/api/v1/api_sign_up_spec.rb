require 'rails_helper'
RSpec.describe Api::V1::RegistrationsController, type: :request do
  before do
    sign_up('test@test.com', 'Makers Academy')
  end

  describe 'signing up' do
    it "returns a JSON when valid sign up" do
      expect(JSON.parse(response.body)).to include "email" => "test@test.com"
    end
  end

  describe 'signing in' do
    it "returns a JSON when valid sign in" do
      sign_in('test@test.com')
      expect(JSON.parse(response.body)).to include "email" => "test@test.com"
    end

    it "does not allow incorrect sign in" do
      sign_in('test2@test.com')
      expect(JSON.parse(response.body)).to eq({"error" => "invalid email and password combination"})
    end
  end

  describe 'signing out' do
    it "signs out" do
      sign_in('test@test.com')
      delete '/api/v1/sign_out'
      expect(response.body).to eq ""
    end
  end
end
