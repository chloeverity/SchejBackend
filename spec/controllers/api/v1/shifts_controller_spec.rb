require 'rails_helper'

RSpec.describe Api::V1::ShiftsController, type: :request do
  let(:user_1_email) {'test@test.com'}
  let(:user_1_org) {'Makers Academy'}
  let(:user_2_email) {'test2@test.com'}
  let(:user_2_org) {'MacDonalds'}

  before(:each) do
    sign_up('test@test.com', 'Makers Academy')
    @user_1_id = (JSON.parse(response.body))["id"]
    post_shift(@user_1_id, user_1_org, user_1_email)
    @shift_1_id = (JSON.parse(response.body))["id"]
  end

  describe 'creating a shift' do
    it 'creates a shift with title, start time and end time' do
      expect(JSON.parse(response.body)).to include "title" => user_1_email
    end
  end

  describe 'index' do
    it "shows all shifts for user's organisation" do
      get_shifts(organisation = 'Makers Academy')
      expect(JSON.parse(response.body).first).to include('title' => user_1_email)
    end

    it "shows all shifts for user 2's organisation and not user 1's organisatio" do
      sign_up(user_2_email, user_2_org)
      user_id2 = (JSON.parse(response.body))["id"]
      post_shift(user_id2, user_2_org, user_2_email)
      get_shifts(organisation = user_2_org)
      expect(JSON.parse(response.body).length).to eq 1
      expect(JSON.parse(response.body).first).not_to include('title' => user_1_email)
    end

  end
  describe 'deleting a shift' do
    it 'deletes a second shift and its information' do
      post_shift(@user_1_id, user_1_org, user_1_email)
      id = (JSON.parse(response.body))["id"]
      delete_shift(id)
      get_shifts(organisation = user_1_org)
      expect(JSON.parse(response.body).length).to eq 1
    end
  end

  describe 'swapping a shift' do
    it "swaps a user's shift with another user's" do
      sign_up(user_2_email, user_2_org)
      user_id2 = (JSON.parse(response.body))["id"]
      post_shift(user_id2, user_2_org, user_2_email)
      shift_2_id = (JSON.parse(response.body))["id"]
      patch "/api/v1/shifts/#{@shift_1_id}", :params => {'other_id' => shift_2_id}

      shift2 = Shift.find(shift_2_id)
      expect(shift2.user_id).to eq @user_1_id
      expect(shift2.title).to eq user_1_email
      shift1 = Shift.find(@shift_1_id)
      expect(shift1.user_id).to eq user_id2
      expect(shift1.title).to eq user_2_email
    end
  end

  describe "viewing a user's shifts" do
    it 'only shows shifts for a given user' do
      post_shift(@user_1_id, user_1_org, user_1_email)
      sign_up(user_2_email, user_1_org)
      user_2_id = (JSON.parse(response.body))["id"]
      post_shift(user_2_id, user_1_org, user_2_email)

      get "/api/v1/shiftsbyuser/#{@user_1_id}"
      expect(JSON.parse(response.body).length).to eq 2
      expect(JSON.parse(response.body).first).to include('user_id' => @user_1_id)
      expect(JSON.parse(response.body).last).to include('user_id' => @user_1_id)
    end
  end
end
