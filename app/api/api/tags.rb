# frozen_string_literal: true

module Api
  class Tags < Grape::API
    include Api::Defaults

    resources :tags do
      desc 'Get all tags'
      get '/' do
        tags = Tag.all
        present tags, with: Api::Entities::Tag
      end

      desc 'Get tag'
      get '/:id' do
        tag = Tag.find(params[:id])
        present tag, with: Api::Entities::Tag
      end

      desc 'Get Members for tag'
      get '/:id/members' do
        tag = Tag.find(params[:id])
        present tag.members, with: Api::Entities::Member
      end

      desc 'Update a tag'
      params do
        requires :name, type: String, desc: 'The name of the tag'
      end
      put '/:id' do
        tag = Tag.find(params[:id])
        tag.update!(name: params[:name])
        present tag, with: Api::Entities::Tag
      end

      desc 'Create tag'
      params do
        requires :name, type: String, desc: 'The name of the tag'
      end
      post '/' do
        tag = Tag.create!(name: params[:name])
        status 201
        present tag, with: Api::Entities::Tag
      end

      desc 'Delete a tag'
      delete '/:id' do
        tag = Tag.find(params[:id])
        tag.destroy!
        status 204
      end
    end
  end
end
