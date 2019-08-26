# frozen_string_literal: true

require 'grape'

module Api
  module Entities
    class Tag < Grape::Entity
      expose :id, documentation: { type: 'Integer', desc: "tag's unique id" }
      expose :name, documentation: { type: 'String', desc: 'Name of the tag' }
    end
  end
end
