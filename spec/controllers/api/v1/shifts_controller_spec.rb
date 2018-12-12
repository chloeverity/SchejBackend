require 'rails_helper'

RSpec.describe Api::V1::ShiftsController, type: :request do

  describe 'creating a shift' do
    it 'creates a shift with title, start time and end time' do
      post '/api/v1/shifts', :params => {'title' => 'test@test.com', 'start_time' => DateTime.now, 'end_time' => DateTime.now}
      p response.body
      expect(JSON.parse(response.body)).to include "title" => "test@test.com"
    end
  end

end
