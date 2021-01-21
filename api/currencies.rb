# frozen_string_literal: true

require_relative 'lib/rates_parser'

module API
  class Currencies < Grape::API
    resource :currencies do
      desc 'Return all market rates'
      get do
        RatesParser.new.markets
      end
    end

    resource :currency do
      desc 'Return a market'
      params do
        requires :base, type: String, desc: 'Base unit name'
        requires :quote, type: String, desc: 'Quote unit name'
      end
      route_param :base do
        route_param :quote do
          get do
            RatesParser.new(params[:base], params[:quote]).market
          end
        end
      end
    end
  end
end
