# frozen_string_literal: true

require 'airborne'
require_relative '../api/root'
require 'pry'

Airborne.configure do |config|
  config.rack_app = API::Root
end

describe API::Currencies do
  context 'GET /api/currencies' do
    it 'returns 200 response' do
      get '/api/currencies'
      expect_status(200)
    end

    it 'returns array of markets' do
      get '/api/currencies'
      expect_json_types(:array)
    end
  end

  context 'GET /api/currency/name' do
    it 'with upcase name' do
      get '/api/currency/BCH/BTC'
      expect_status(200)
    end

    it 'with downcase name' do
      get '/api/currency/bch/btc'
      expect_status(200)
    end

    it 'returns a market' do
      get '/api/currency/BCH/BTC'
      expect_json(market: regex('^BCH/BTC'))
    end
  end
end
