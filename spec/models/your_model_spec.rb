# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Models::YourModel do
  describe '.all' do
    it 'returns an array of Models::YourModel objects' do
      retorno = described_class.all

      expect(retorno.all? do |item|
        item.is_a?(described_class)
      end).to be true
    end
  end
end
