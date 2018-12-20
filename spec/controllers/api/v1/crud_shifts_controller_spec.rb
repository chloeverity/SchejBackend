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
  let(:user_2_job_title) { 'chef' }
  let(:user_3_email) { 'test3@test.com' }
  let(:user_3_name) { 'user3' }
  let(:user_3_org) { 'Makers Academy' }
  let(:user_3_job_title) { 'assistant coach' }

  before(:each) do
    @user_1_id = sign_up_get_user_id(
      user_1_email,
      user_1_org,
      user_1_name,
      user_1_job_title
    )
    @shift_1_id = post_shift_get_id(@user_1_id)
  end

  describe 'creating a shift' do
    it 'creates a shift with title, start time and end time' do
      expect(JSON.parse(response.body)).to include 'email' => user_1_email
    end
  end

  describe 'index by organisation' do
    it "shows all shifts for user's organisation" do
      get_shifts(user_1_org, user_1_job_title)
      expect(JSON.parse(response.body).first)
        .to include('email' => user_1_email)
      expect(JSON.parse(response.body).first)
        .to include('title' => user_1_name)
    end

    it "shows all shifts for user 2's organisation and not user 1's " do
      user_id2 = sign_up_get_user_id(
        user_2_email,
        user_2_org,
        user_2_name,
        user_2_job_title
      )
      post_shift_get_id(user_id2)
      get_shifts(user_2_org, user_2_job_title)
      expect(JSON.parse(response.body).length).to eq 1
      expect(JSON.parse(response.body).first).not_to include(
        'email' => user_1_email
      )
    end
  end

  describe 'index by title' do
    it "shows all shifts for user's title" do
      get_shifts(user_1_org, user_1_job_title)
      expect(JSON.parse(response.body).first).to include(
        'email' => user_1_email
      )
      expect(JSON.parse(response.body).first).to include('title' => user_1_name)
    end

    it "shows all shifts for user 3's job title and not user 1's job title" do
      user_id3 = sign_up_get_user_id(
        user_3_email,
        user_3_org,
        user_3_name,
        user_3_job_title
      )
      post_shift_get_id(user_id3)
      get_shifts(user_3_org, user_3_job_title)
      expect(JSON.parse(response.body).length).to eq 1
      expect(JSON.parse(response.body).first).not_to include(
        'email' => user_1_email
      )
    end
  end

  describe 'deleting a shift' do
    it 'deletes a second shift and its information' do
      delete_shift(@shift_1_id)
      get_shifts(user_1_org, user_1_job_title)
      expect(JSON.parse(response.body).length).to eq 0
    end
  end
end
