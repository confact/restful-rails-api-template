# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tag, type: :model do
  it 'create a member' do
    tag = Tag.create(name: 'name')
    expect(tag.name).to eq('name')
  end

  describe 'validation' do
    it 'validate name presence' do
      expect(FactoryBot.build(:tag, name: "")).not_to be_valid
    end
  end
end
