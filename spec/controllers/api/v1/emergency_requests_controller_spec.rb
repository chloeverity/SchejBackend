require 'rails_helper'

RSpec.describe Api::V1::EmergencyRequestsController, type: :request do

  let(:user_1_email) { 'test@test.com' }
  let(:org) { 'Makers Academy' }
  let(:user_1_name) { 'user1' }
  let(:job_title) {'coach'}
  let(:user_2_email) { 'test2@test.com' }
  let(:user_2_name) { 'user2' }
  let(:user_3) { {email: 'test3@test.com', name: 'user3', job_title: 'manager' } }

  before(:each) do
    @user_1_id = sign_up_get_user_id(user_1_email, org, user_1_name, job_title)
    @shift_1_id = post_shift_get_id(@user_1_id)
    @user_2_id = sign_up_get_user_id(user_2_email, org, user_2_name, job_title)
    @user_3_id = sign_up_get_user_id(user_3[:email], org, user_3[:name], user_3[:job_title])
  end

  describe 'new emergency request' do
    it 'creates a new emergency request' do
      post '/api/v1/emergency_requests', params: { 'emergency_shift_id' => @shift_1_id, 'comment' => 'hello' }
      expect(JSON.parse(response.body)).to include "userId" => @user_1_id
    end

    it 'shows all emergency notifications for the same organisation and job title' do
      post '/api/v1/emergency_requests', params: { 'emergency_shift_id' => @shift_1_id, 'comment' => 'hello' }
      get '/api/v1/emergency_requests', params: { 'user_id' => @user_2_id }
      expect(JSON.parse(response.body).first).to include "userId" => @user_1_id
      expect(JSON.parse(response.body).first).to include "shiftId" => @shift_1_id
    end

    it 'does not show emergency request if user has different job title to requester' do
      post '/api/v1/emergency_requests', params: { 'emergency_shift_id' => @shift_1_id, 'comment' => 'hello' }
      get '/api/v1/emergency_requests', params: { 'user_id' => @user_3_id }
      expect(JSON.parse(response.body).length).to eq 0
    end

    it 'deletes the emergency request' do
      post '/api/v1/emergency_requests', params: { 'emergency_shift_id' => @shift_1_id, 'comment' => 'hello' }
      id = JSON.parse(response.body)['id']
      delete "/api/v1/emergency_requests/#{id}"
      expect(EmergencyRequest.all.length).to eq 0
    end
  end

end
