# frozen_string_literal: true

require 'httparty'

class RatesParser
  attr_reader :markets, :market

  def initialize(base = nil, quote = nil)
    markets_data = url_parse

    @markets = find_markets(markets_data)
    @market = find_market(base, quote) if base && quote
  end

  private

  def find_markets(data)
    data.map do |name, rates|
      units = split_title(name)
      { market: name, base_unit: units.first, quote_unit: units.last, last_price: rates['Last-price'].to_f }
    end
  end

  def find_market(base, quote)
    name = "#{base.upcase}/#{quote.upcase}"
    @markets.detect { |element| element[:market] == name }
  end

  def split_title(name)
    name.downcase.split('/')
  end

  def url_parse
    response = HTTParty.get('https://absrest.realexchange.pro/public/tickers24h')
    json = JSON.parse(response.body)

    json.values.first
  end
end
