# frozen_string_literal: true

require_relative '../config/application'

module Db
  class Seeds
    # Populate the database with initial data
    def self.call
      ::Flipper[:awesome_feature].enable
    end
  end
end
