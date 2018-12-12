require 'rails_helper'

RSpec.describe Api::V1::ShiftsController, type: :request do
  # let(:current_user) { double current_user }
  #
  before do
    # allow(current_user).to receive(:id).and_return('1')
    post '/api/v1/sign_up', :params => {'email' => 'test@test.com', 'password' => 'testpassword', 'password_confirmation' => 'testpassword'}
  end

  describe 'creating a shift' do
    it 'creates a shift with title, start time and end time' do
      post '/api/v1/shifts', :params => {'title' => 'test@test.com', 'start_time' => DateTime.now, 'end_time' => DateTime.now}
      p response.body
      expect(JSON.parse(response.body)).to include "title" => "test@test.com"
    end
  end
  describe 'index' do

    it 'shows all shifts' do
      post '/api/v1/shifts', :params => {'title' => 'test@test.com', 'start_time' => DateTime.now, 'end_time' => DateTime.now}
      get '/api/v1/shifts'
      expect(JSON.parse(response.body).first).to include('title' => 'test@test.com')
    end
  end
  # describe 'deleting a shift' do
  #   it 'deletes a shift and its information' do
  #     post '/api/v1/shifts', :params => {'title' => 'test@test.com', 'start_time' => DateTime.now, 'end_time' => DateTime.now}
  #     delete '/api/v1/shifts/id'
  #   end
  # end

end
