require 'rails_helper'

RSpec.describe Api::V1::ShiftsController, type: :request do
  let(:user) { double :current_user }

  before(:each) do
    allow(user).to receive(:id).and_return('1')
    allow_any_instance_of(Api::V1::ShiftsController).to receive(:current_user).and_return(user)
    post '/api/v1/sign_up', :params => {'email' => 'test@test.com', 'password' => 'testpassword', 'password_confirmation' => 'testpassword'}
  end

  describe 'creating a shift' do
    it 'creates a shift with title, start time and end time' do
      post '/api/v1/shifts', :params => {'title' => 'test@test.com', 'start_time' => 1517540400000, 'end_time' => 1517540400000, 'user_id' => 1}
      p response.body
      expect(JSON.parse(response.body)).to include "title" => "test@test.com"
    end
  end
  describe 'index' do

    it 'shows all shifts' do
      p User.all
      post '/api/v1/sign_in', :params => {'email' => 'test@test.com', 'password' => 'testpassword'}
      post '/api/v1/shifts', :params => {'title' => 'test@test.com', 'start_time' => 1517540400000, 'end_time' => 1517540400000, 'user_id' => 2}
      get '/api/v1/shifts'
      expect(JSON.parse(response.body).first).to include('title' => 'test@test.com')
    end
  end
  describe 'deleting a shift' do
    it 'deletes a shift and its information' do
      post '/api/v1/shifts', :params => {'title' => 'test@test.com', 'start_time' => 1517540400000, 'end_time' => 1517540400000, 'user_id' => 3}
      post '/api/v1/shifts', :params => {'title' => 'test1@test.com', 'start_time' => 1517540400000, 'end_time' => 1517540400000, 'user_id' => 3}
      id = 3
      delete "/api/v1/shifts/#{id}"
      get '/api/v1/shifts'
      expect(JSON.parse(response.body).first).not_to include('title' => 'test@test.com')
    end
  end

end
