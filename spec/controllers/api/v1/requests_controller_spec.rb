require 'rails_helper'

RSpec.describe Api::V1::RequestsController, type: :request do

  let(:user_1_email) { 'test@test.com' }
  let(:org) { 'Makers Academy' }
  let(:user_1_name) { 'user1' }
  let(:user_2_email) { 'test2@test.com' }
  let(:user_2_name) { 'user2' }

  before(:each) do
    @user_1_id =  sign_up_get_user_id(user_1_email, org, user_1_name)
    @shift_1_id = post_shift_get_id(@user_1_id)
    @user_2_id = sign_up_get_user_id(user_2_email, org, user_2_name)
    @shift_2_id = post_shift_get_id(@user_2_id)
  end

  describe 'new request' do
    it ' creates a new request' do
      post '/api/v1/requests', params: { 'requested_shift_id' => @shift_1_id, 'current_shift_id' => @shift_2_id }
      expect(JSON.parse(response.body)['requestedShift']).to include "userId" => @user_1_id
      expect(JSON.parse(response.body)['currentShift']).to include "userId" => @user_2_id
    end
  end

  describe 'show requests for user' do
    it 'shows all requests for a user where they are the current shift holder' do
      post '/api/v1/requests', params: { 'requested_shift_id' => @shift_1_id, 'current_shift_id' => @shift_2_id , 'comment' => "clash with my dentist appointment"}
      get "/api/v1/requestsbyuser/#{@user_1_id}"
      expect(JSON.parse(response.body).length).to eq 1
      expect(JSON.parse(response.body).first['currentShift']).to include('userId' => @user_2_id)
      expect(JSON.parse(response.body).first['currentShift']).to include('id' => @shift_2_id)
      expect(JSON.parse(response.body).first).to include 'comment' => "clash with my dentist appointment"
    end
  end

  describe 'delete request' do
    it "delete the shift request once resolved" do
      post '/api/v1/requests', params: { 'requested_shift_id' => @shift_1_id, 'current_shift_id' => @shift_2_id  }
      @request_id = JSON.parse(response.body)['id']
      delete	"/api/v1/requests/#{@request_id}"
      get "/api/v1/requestsbyuser/#{@user_1_id}"
      expect(JSON.parse(response.body).length).to eq 0
    end
  end

end
