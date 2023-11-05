# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ThemealdbService do
  describe 'random' do
    let(:response_body) { '{"meals":[{"idMeal":"52773", "name":"test1"}]}' }
    let(:expected_data) do
      {
        'meals' => [
          {
            'idMeal' => '52773',
            'name' => 'test1'
          }
        ]
      }
    end

    before do
      stub_request(:get, "https://www.themealdb.com/api/json/v1/1/random.php")
        .with(
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent' => "Faraday v#{Faraday::VERSION}"
          }
        ).to_return(
          status: 200,
          body: response_body,
          headers: {}
        )
    end

    it 'success' do
      expect(described_class.new.random).to eq(expected_data)
    end
  end
end