# frozen_string_literal: true

class Member < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  validates :name, presence: true
  validates :role, presence: { if: :employee? }
  validates :duration, presence: { if: :contractor? }

  enum member_type: {
    contractor: 1,
    employee: 2
  }

end
