# frozen_string_literal: true

# :no-doc:
module Models
  # Model for "flipper_features"
  class Feature
    attr_reader :flipper_feature
    def initialize(flipper_feature)
      @flipper_feature = flipper_feature
    end

    def as_json
      {
        name: flipper_feature.name,
        gates: gates,
        enabled_gates: flipper_feature.enabled_gate_names,
        state: flipper_feature.state
      }
    end

    def gates
      flipper_feature.gates.map do |gate|
        {
          key: gate.key,
          name: gate.name,
          value: parse_gate_value(gate.key)
        }
      end
    end

    private

    def parse_gate_value(gate_key)
      value = flipper_feature.gate_values[gate_key]
      value.is_a?(Set) ? value.to_a : value
    end
  end
end
