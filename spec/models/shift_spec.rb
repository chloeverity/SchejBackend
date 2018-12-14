# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Shift, type: :model do
  it 'belongs to a user' do
    association = described_class.reflect_on_association(:user).macro
    expect(association).to eq :belongs_to
  end
end
