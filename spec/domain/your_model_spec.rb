# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Domain::YourModel do
  describe '.all' do
    it 'returns an array of Domain::YourModel objects' do
      retorno = described_class.all

      expect(retorno.all? do |item|
        item.is_a?(described_class)
      end).to be true
    end
  end
end
