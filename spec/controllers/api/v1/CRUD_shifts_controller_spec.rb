# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ShiftsController, type: :request do
  let(:user_1_email) { 'test@test.com' }
  let(:user_1_org) { 'Makers Academy' }
  let(:user_1_name) { 'user1' }
  let(:user_2_email) { 'test2@test.com' }
  let(:user_2_org) { 'MacDonalds' }
  let(:user_2_name) { 'user2' }

  before(:each) do
    @user_1_id = sign_up_get_user_id(user_1_email, user_1_org, user_1_name)
    @shift_1_id = post_shift_get_id(@user_1_id)
  end

  describe 'creating a shift' do
    it 'creates a shift with title, start time and end time' do
      expect(JSON.parse(response.body)).to include 'email' => user_1_email
    end
  end

  describe 'index' do
    it "shows all shifts for user's organisation" do
      get_shifts(organisation = 'Makers Academy')
      expect(JSON.parse(response.body).first).to include('email' => user_1_email)
      expect(JSON.parse(response.body).first).to include('title' => user_1_name)
    end

    it "shows all shifts for user 2's organisation and not user 1's organisatio" do
      user_id2 = sign_up_get_user_id(user_2_email, user_2_org, user_2_name)
      post_shift_get_id(user_id2)
      get_shifts(organisation = user_2_org)
      expect(JSON.parse(response.body).length).to eq 1
      expect(JSON.parse(response.body).first).not_to include('email' => user_1_email)
    end
  end

  describe 'deleting a shift' do
    it 'deletes a second shift and its information' do
      delete_shift(@shift_1_id)
      get_shifts(organisation = user_1_org)
      expect(JSON.parse(response.body).length).to eq 0
    end
  end
end
