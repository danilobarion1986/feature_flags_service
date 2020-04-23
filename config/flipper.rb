# frozen_string_literal: true

require 'flipper'
require 'flipper-ui'
require 'flipper-api'
require 'flipper/adapters/sequel'

Flipper.configure do |config|
  config.default do
    adapter = Flipper::Adapters::Sequel.new
    Flipper.new(adapter)
  end
end

# It allows managing flags visually
# https://github.com/jnunemaker/flipper/tree/master/docs/ui
FLIPPER_UI_APP = Flipper::UI.app(Flipper) { |builder|
  builder.use Rack::Session::Cookie, secret: "something long and random"
}

# It allows managing flags with API requests
# https://github.com/jnunemaker/flipper/blob/master/docs/api
FLIPPER_API_APP = Flipper::Api.app(Flipper)
