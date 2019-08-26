# frozen_string_literal: true

module Api
  class Base < Grape::API
    format :json

    mount Api::Members
    mount Api::Tags
  end
end
