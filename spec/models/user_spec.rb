# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has many shifts' do
    association = described_class.reflect_on_association(:shifts).macro
    expect(association).to eq :has_many
  end
end
