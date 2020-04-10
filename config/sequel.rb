# frozen_string_literal: true

require 'sequel'
DB = Sequel.connect(CONNECTION_OPTIONS)

# https://sequel.jeremyevans.net/rdoc-plugins/classes/Sequel/Plugins/JsonSerializer.html
Sequel::Model.plugin :json_serializer
