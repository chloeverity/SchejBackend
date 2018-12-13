# frozen_string_literal: true

require_relative 'time_date_js_ruby_converter'

describe 'rubytojsconverter' do
  it 'converts a ruby date time to js milliseconds' do
    ruby_time = Time.parse('2018-02-02 03:00:00 +0000')
    expect(convert_to_js(ruby_time)).to eq 1_517_540_400_000
  end

  it 'converts a js milliseconds time to ruby DateTime' do
    js_time = 1_517_540_400_000
    expect(convert_to_ruby(js_time).year).to eq 2018
    expect(convert_to_ruby(js_time).month).to eq 2
    expect(convert_to_ruby(js_time).day).to eq 2
    expect(convert_to_ruby(js_time).hour).to eq 3
  end
end
