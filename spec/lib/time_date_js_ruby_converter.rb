# frozen_string_literal: true

def convert_to_ruby(milliseconds)
  Time.at(milliseconds / 1000.0)
end

def convert_to_js(rubytime)
  rubytime.to_f * 1000
end
