# frozen_string_literal: true

require 'grape'
require_relative './currencies'

module API
  class Root < Grape::API
    version 'v1', using: :header, vendor: 'currencies'
    format :json
    prefix :api

    mount API::Currencies
  end
end
