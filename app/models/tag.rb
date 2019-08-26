# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :members, through: :taggings

  validates :name, presence: true
end
