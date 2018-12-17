# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ShiftsController, type: :request do
  let(:user_1_email) { 'test@test.com' }
  let(:user_1_org) { 'Makers Academy' }
  let(:user_1_name) { 'user1' }
  let(:user_1_job_title) { 'coach' }
  let(:user_2_email) { 'test2@test.com' }
  let(:user_2_org) { 'MacDonalds' }
  let(:user_2_name) { 'user2' }
  let(:user_2_job_title) { 'coach' }
  let(:user_3_email) { 'test3@test.com' }
  let(:user_3_org) { 'Makers Academy' }
  let(:user_3_name) { 'user3' }
  let(:user_3_job_title) { 'coach' }

  before(:each) do
    @user_1_id = sign_up_get_user_id(
      user_1_email,
      user_1_org,
      user_1_name,
      user_1_job_title
    )
    @shift_1_id = post_shift_get_id(@user_1_id)
  end

  describe 'swapping a shift' do
    it "swaps a user's shift with another user's" do
      user_id2 = sign_up_get_user_id(
        user_2_email,
        user_2_org,
        user_2_name,
        user_2_job_title
      )
      shift_2_id = post_shift_get_id(user_id2)
      patch "/api/v1/shifts/#{@shift_1_id}", params: {
        'other_id' => shift_2_id
      }

      shift2 = Shift.find(shift_2_id)
      expect(shift2.user_id).to eq @user_1_id
      expect(shift2.title).to eq user_1_name
      expect(shift2.email).to eq user_1_email
      shift1 = Shift.find(@shift_1_id)
      expect(shift1.user_id).to eq user_id2
      expect(shift1.title).to eq user_2_name
      expect(shift1.email).to eq user_2_email
    end
  end

  describe "viewing a user's shifts" do
    it 'only shows shifts for a given user' do
      post_shift_get_id(@user_1_id)
      user_3_id = sign_up_get_user_id(
        user_3_email,
        user_3_org,
        user_3_name,
        user_3_job_title
      )
      post_shift_get_id(user_3_id)

      get_shifts_by_user(@user_1_id)
      expect(JSON.parse(response.body).length).to eq 2
      expect(JSON.parse(response.body).first)
        .to include('user_id' => @user_1_id)
      expect(JSON.parse(response.body).last)
        .to include('user_id' => @user_1_id)
    end
  end
end
