# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Member, type: :model do
  it 'create a member' do
    member = Member.create(name: 'name', role: :contractor, duration: 1.weeks)
    expect(member.name).to eq('name')
    expect(member.role).to eq('contractor')
    expect(member.duration).to eq(1.weeks)
  end

  describe 'validation' do
    it 'validate role specific' do
      expect(FactoryBot.build(:member_contractor, duration: nil)).not_to be_valid
    end
    it 'validate role specific' do
      expect(FactoryBot.build(:member_employee, role: nil)).not_to be_valid
    end
    it 'validate name presence' do
      expect(FactoryBot.build(:member, name: "")).not_to be_valid
    end
  end

  describe 'tags' do
    it 'be able to add' do
      member = FactoryBot.create(:member_employee)
      expect(member.tags.count).to eq(0)
      tag = FactoryBot.create(:tag)
      member.tags << tag
      expect(member.tags.count).to eq(1)
    end
  end
end
