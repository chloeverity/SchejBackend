# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Api::V1::RegistrationsController, type: :request do
  let(:user_1_email) { 'test@test.com' }
  let(:user_1_org) { 'Makers Academy' }
  let(:user_1_name) { 'user1' }
  let(:user_1_job_title) { 'coach' }

  before do
    sign_up_get_user_id(user_1_email, user_1_org, user_1_name, user_1_job_title)
  end

  describe 'signing up' do
    it 'returns a JSON when valid sign up' do
      expect(JSON.parse(response.body)).to include 'email' => user_1_email
    end
  end

  describe 'signing in' do
    it 'returns a JSON when valid sign in' do
      sign_in(user_1_email)
      expect(JSON.parse(response.body)).to include 'email' => user_1_email
    end

    it 'does not allow incorrect sign in' do
      sign_in('test2@test.com')
      expect(JSON.parse(response.body)).to eq('error' => 'invalid email and password combination')
    end
  end

  describe 'signing out' do
    it 'signs out' do
      sign_in(user_1_email)
      delete '/api/v1/sign_out'
      expect(response.body).to eq ''
    end
  end
end
