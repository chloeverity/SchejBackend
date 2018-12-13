require 'rails_helper'

RSpec.describe Api::V1::ShiftsController, type: :request do
  let(:user) { double :current_user }

  before(:each) do
    post '/api/v1/sign_up', :params => {'email' => 'test@test.com', 'password' => 'testpassword', 'password_confirmation' => 'testpassword', 'organisation' => 'Makers Academy'}
    @user_id = (JSON.parse(response.body))["id"]
  end

  describe 'creating a shift' do
    it 'creates a shift with title, start time and end time' do
      post '/api/v1/shifts', :params => {'title' => 'test@test.com', 'start_time' => 1517540400000, 'end_time' => 1517540400000, 'user_id' => @user_id, 'organisation' => 'Makers Academy' }
      expect(JSON.parse(response.body)).to include "title" => "test@test.com"
    end
  end

  describe 'index' do

    it "shows all shifts for user's organisation" do
      post '/api/v1/sign_in', :params => {'email' => 'test@test.com', 'password' => 'testpassword'}
      post '/api/v1/shifts', :params => {'title' => 'test@test.com', 'start_time' => 1517540400000, 'end_time' => 1517540400000, 'user_id' => @user_id, 'organisation' => 'Makers Academy'}
      get '/api/v1/shifts', :params => {'organisation' => 'Makers Academy'}
      expect(JSON.parse(response.body).first).to include('title' => 'test@test.com')
    end

    it "shows all shifts for user's organisation where more than one organisation exists" do
      post '/api/v1/sign_in', :params => {'email' => 'test@test.com', 'password' => 'testpassword'}
      post '/api/v1/shifts', :params => {'title' => 'test@test.com', 'start_time' => 1517540400000, 'end_time' => 1517540400000, 'user_id' => @user_id, 'organisation' => 'Makers Academy'}
      post '/api/v1/sign_up', :params => {'email' => 'test2@test.com', 'password' => 'testpassword', 'password_confirmation' => 'testpassword', 'organisation' => 'MacDonalds'}
      user_id2 = (JSON.parse(response.body))["id"]
      post '/api/v1/shifts', :params => {'title' => 'test2@test.com', 'start_time' => 1517540400000, 'end_time' => 1517540400000, 'user_id' => user_id2, 'organisation' => 'MacDonalds'}
      get '/api/v1/shifts', :params => {'organisation' => 'MacDonalds'}
      expect(JSON.parse(response.body).first).not_to include('title' => 'test@test.com')
    end

  end
  describe 'deleting a shift' do
    it 'deletes a shift and its information' do
      post '/api/v1/shifts', :params => {'title' => 'test@test.com', 'start_time' => 1517540400000, 'end_time' => 1517540400000, 'user_id' => @user_id, 'organisation' => 'Makers Academy'}
      id = (JSON.parse(response.body))["id"]
      post '/api/v1/shifts', :params => {'title' => 'test1@test.com', 'start_time' => 1517540400000, 'end_time' => 1517540400000, 'user_id' => @user_id, 'organisation' => 'Makers Academy'}
      delete "/api/v1/shifts/#{id}"
      get '/api/v1/shifts', :params => {'organisation' => 'Makers Academy'}
      expect(JSON.parse(response.body).first).not_to include('title' => 'test@test.com')
    end
  end

end
