# frozen_string_literal: true

require 'flipper'
require 'flipper-ui'
require 'flipper/adapters/sequel'

Flipper.configure do |config|
  config.default do
    adapter = Flipper::Adapters::Sequel.new
    Flipper.new(adapter)
  end
end

FLIPPER_UI_APP = Flipper::UI.app(Flipper) { |builder|
  builder.use Rack::Session::Cookie, secret: "something long and random"
}
