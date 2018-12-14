require 'rails_helper'

RSpec.describe 'request status', type: :request do

  describe 'GET/status' do
    it 'returns a status message' do
      post '/api/v1/sign_up'
      expect(JSON.parse(response.body)).to eql({
        "email"=>["can't be blank"],
        "password"=>["can't be blank"]
        })
    end
  end
end
