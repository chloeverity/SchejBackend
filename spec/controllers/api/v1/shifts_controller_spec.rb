require 'rails_helper'

RSpec.describe Api::V1::ShiftsController, type: :request do
  let(:user) { double :current_user }

  before(:each) do
    sign_up
    @user_id = (JSON.parse(response.body))["id"]
    post_shift(@user_id)
  end

  describe 'creating a shift' do
    it 'creates a shift with title, start time and end time' do
      expect(JSON.parse(response.body)).to include "title" => "test@test.com"
    end
  end

  describe 'index' do
    it "shows all shifts for user's organisation" do
      get_shifts(organisation = 'Makers Academy')
      expect(JSON.parse(response.body).first).to include('title' => 'test@test.com')
    end

    it "shows all shifts for user's organisation where more than one organisation exists" do
      sign_up(user_1 = false)
      user_id2 = (JSON.parse(response.body))["id"]
      post_shift(user_id2, user_1 = false)
      get_shifts(organisation = 'MacDonalds')
      expect(JSON.parse(response.body).first).not_to include('title' => 'test@test.com')
    end

  end
  describe 'deleting a shift' do
    it 'deletes a shift and its information' do
      post_shift(@user_id)
      id = (JSON.parse(response.body))["id"]
      delete_shift(id)
      get_shifts(organisation = 'Makers Academy')
      expect(JSON.parse(response.body).length).to eq 1 
    end
  end
end
