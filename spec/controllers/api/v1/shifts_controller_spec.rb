require 'rails_helper'

RSpec.describe Api::V1::ShiftsController, type: :request do
  let(:user) { double :current_user }

  before(:each) do
    post '/api/v1/sign_up', :params => {'email' => 'test@test.com', 'password' => 'testpassword', 'password_confirmation' => 'testpassword'}
    @user_id = (JSON.parse(response.body))["id"]
  end

  describe 'creating a shift' do
    it 'creates a shift with title, start time and end time' do
      post '/api/v1/shifts', :params => {'title' => 'test@test.com', 'start_time' => 1517540400000, 'end_time' => 1517540400000, 'user_id' => @user_id}
      expect(JSON.parse(response.body)).to include "title" => "test@test.com"
    end
  end

  describe 'index' do

    it 'shows all shifts' do
      post '/api/v1/sign_in', :params => {'email' => 'test@test.com', 'password' => 'testpassword'}
      post '/api/v1/shifts', :params => {'title' => 'test@test.com', 'start_time' => 1517540400000, 'end_time' => 1517540400000, 'user_id' => @user_id}
      get '/api/v1/shifts'
      expect(JSON.parse(response.body).first).to include('title' => 'test@test.com')
    end
  end
  describe 'deleting a shift' do
    it 'deletes a shift and its information' do
      post '/api/v1/shifts', :params => {'title' => 'test@test.com', 'start_time' => 1517540400000, 'end_time' => 1517540400000, 'user_id' => @user_id}
      id = (JSON.parse(response.body))["id"]
      post '/api/v1/shifts', :params => {'title' => 'test1@test.com', 'start_time' => 1517540400000, 'end_time' => 1517540400000, 'user_id' => @user_id}
      delete "/api/v1/shifts/#{id}"
      get '/api/v1/shifts'
      expect(JSON.parse(response.body).first).not_to include('title' => 'test@test.com')
    end
  end

end
