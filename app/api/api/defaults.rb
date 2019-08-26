# frozen_string_literal: true

module Api
  module Defaults
    extend ActiveSupport::Concern

    included do
      format :json

      # Global handler for simple not found case
      rescue_from ActiveRecord::RecordNotFound do |exception|
        error!(exception.message, 404)
      end

      rescue_from ActiveRecord::RecordInvalid do |exception|
        error!(exception.message, 409)
      end
      # Global exception handler, used for error notifications
      rescue_from :all do |e|
        if Rails.env.development?
          raise e
        else
          error!(e.message, 500)
        end
      end

      helpers do
        def member_params(params)
          {
            name: params[:name],
            member_type: params[:type],
            role: params[:role],
            duration: params[:duration]
          }.compact
        end
      end

    end
  end
end
