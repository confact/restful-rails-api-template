# frozen_string_literal: true

class Tagging < ApplicationRecord
  belongs_to :member
  belongs_to :tag
end
