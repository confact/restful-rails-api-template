# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::Members do
  it 'create a member' do
    post '/api/members', params: { name: 'A name', type: 2, role: 'software engineer' }
    parsed_body = JSON.parse(response.body)
    expect(response).to be_successful
    expect(parsed_body['role']).to eq('software engineer')
  end

  it 'error on creating a member' do
    post '/api/members', params: { name: 'A name', type: 2, role: '' }
    parsed_body = JSON.parse(response.body)
    expect(response).not_to be_successful
    expect(parsed_body['error']).to include("Role can't be blank")
  end

  it 'get a member' do
    member = FactoryBot.create(:member_employee)
    get "/api/members/#{member.id}"
    expect(response).to be_successful
    parsed_body = JSON.parse(response.body)
    expect(parsed_body['id']).to eq(member.id)
  end

  it 'add tag to member' do
    member = FactoryBot.create(:member_employee)
    tag = FactoryBot.create(:tag)
    post "/api/members/#{member.id}/tags", params: { tag_id: tag.id }
    expect(response).to be_successful
    parsed_body = JSON.parse(response.body)
    expect(parsed_body['id']).to eq(tag.id)
  end

  it 'remove a tag from a member' do
    member = FactoryBot.create(:member_employee)
    tag = FactoryBot.create(:tag, members: [member])
    delete "/api/members/#{member.id}/tags/#{tag.id}"
    expect(response).to be_successful
    expect(member.tags.count).to eq(0)
    expect(Tag.count).to eq(1)
    expect(response.status).to eq(204)
  end

  it 'get all members' do
    FactoryBot.create(:member_employee)
    get '/api/members/'
    expect(response).to be_successful
    parsed_body = JSON.parse(response.body)
    expect(parsed_body.class).to eq(Array)
    expect(parsed_body.length).to eq(1)
  end

  it 'remove a member' do
    member = FactoryBot.create(:member_employee)
    delete "/api/members/#{member.id}"
    expect(response).to be_successful
    expect(response.status).to eq(204)
  end

  it 'update a member' do
    member = FactoryBot.create(:member_employee)
    put "/api/members/#{member.id}", params: { role: 'Lead Engineer' }
    expect(response).to be_successful
    parsed_body = JSON.parse(response.body)
    expect(parsed_body['role']).to eq('Lead Engineer')
    member.reload
    expect(member.role).to eq('Lead Engineer')
  end
end
