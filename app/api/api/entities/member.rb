# frozen_string_literal: true

require 'grape'

module Api
  module Entities
    class Member < Grape::Entity
      expose :id, documentation: { type: 'Integer', desc: "Member's unique id" }
      expose :name, documentation: { type: 'String', desc: "Member's name" }
      expose :member_type, as: :type
      expose :duration, if: proc { |member| member.member_type == 'contractor' }
      expose :role, if: proc { |member| member.member_type == 'employee' }
      expose :tags, using: Api::Entities::Tag
    end
  end
end
