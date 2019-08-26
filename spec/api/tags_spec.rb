# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::Members do
  it 'create a tag' do
    post '/api/tags', params: { name: 'tag name' }.as_json
    parsed_body = JSON.parse(response.body)
    expect(response).to be_successful
    expect(parsed_body['name']).to eq('tag name')
  end

  it "get a tag's members" do
    member = FactoryBot.create(:member_employee)
    tag = FactoryBot.create(:tag, members: [member])
    get "/api/tags/#{tag.id}/members"
    expect(response).to be_successful
    parsed_body = JSON.parse(response.body)
    expect(parsed_body.length).to equal(1)
  end

  it 'get a tag' do
    tag = FactoryBot.create(:tag)
    get "/api/tags/#{tag.id}"
    expect(response).to be_successful
    parsed_body = JSON.parse(response.body)
    expect(parsed_body['id']).to equal(tag.id)
  end

  it 'get all members' do
    FactoryBot.create(:tag)
    get '/api/tags/'
    expect(response).to be_successful
    parsed_body = JSON.parse(response.body)
    expect(parsed_body.class).to eq(Array)
    expect(parsed_body.length).to eq(1)
  end

  it 'remove a tag' do
    tag = FactoryBot.create(:tag)
    delete "/api/tags/#{tag.id}"
    expect(response).to be_successful
    expect(response.status).to eq(204)
  end

  it 'update a tag' do
    tag = FactoryBot.create(:tag)
    put "/api/tags/#{tag.id}", params: { name: 'C#' }
    expect(response).to be_successful
    parsed_body = JSON.parse(response.body)
    expect(parsed_body['name']).to eq('C#')
    tag.reload
    expect(tag.name).to eq('C#')
  end
end
