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
      delete_shift(@shift_1_id)
      get_shifts(organisation = user_1_org)
      expect(JSON.parse(response.body).length).to eq 0
    end
  end
end
