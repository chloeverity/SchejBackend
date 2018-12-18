require 'rails_helper'

RSpec.describe Api::V1::EmergencyRequestsController, type: :request do

  let(:user_1_email) { 'test@test.com' }
  let(:org) { 'Makers Academy' }
  let(:user_1_name) { 'user1' }
  let(:job_title) {'coach'}
  let(:user_2_email) { 'test2@test.com' }
  let(:user_2_name) { 'user2' }

  before(:each) do
    @user_1_id = sign_up_get_user_id(user_1_email, org, user_1_name, job_title)
    @shift_1_id = post_shift_get_id(@user_1_id)
  end

  describe 'new emergency request' do
    it 'creates a new emergency request' do
      post '/api/v1/emergency_requests', params: { 'emergency_shift_id' => @shift_1_id, 'comment' => 'hello' }
      expect(JSON.parse(response.body)).to include "userId" => @user_1_id
    end
  end

end
