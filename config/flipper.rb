# frozen_string_literal: true

require 'flipper'
require 'flipper/adapters/sequel'

Flipper.configure do |config|
  config.default do
    adapter = Flipper::Adapters::Sequel.new
    Flipper.new(adapter)
  end
end
