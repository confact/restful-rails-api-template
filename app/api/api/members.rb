# frozen_string_literal: true

module Api
  class Members < Grape::API
    include Api::Defaults

    resources :members do
      desc 'Get all members'
      get '/' do
        members = Member.all
        present members, with: Api::Entities::Member
      end

      desc 'Get member'
      get '/:id' do
        member = Member.find(params[:id])
        present member, with: Api::Entities::Member
      end

      desc 'Get Tags for member'
      get '/:id/tags' do
        member = Member.find(params[:id])
        present member.tags, with: Api::Entities::Tag
      end

      desc 'Add Tags to member'
      params do
        requires :tag_id, type: Integer, desc: 'The tag id'
      end
      post '/:id/tags' do
        member = Member.find(params[:id])
        tag = Tag.find(params[:tag_id])
        member.tags << tag
        status 201
        present tag, with: Api::Entities::Tag
      end

      desc 'Remove Tag on a member'
      delete '/:id/tags/:tag_id' do
        tagging = Tagging.find_by(member_id: params[:id], tag_id: params[:tag_id])
        tagging.destroy!
        status 204
      end

      desc 'Update a member'
      params do
        optional :name, type: String, desc: 'The name of the member'
        optional :type, type: Integer, desc: 'type of member, 1 for contractor, 2 for employee'
        optional :role, type: String, desc: 'name of role, only for employee'
        optional :duration, type: Integer, desc: 'duration of the contract, only for contractor'
      end
      put '/:id' do
        member = Member.find(params[:id])
        member.update!(member_params(params))
        present member, with: Api::Entities::Member
      end

      desc 'Create member'
      params do
        requires :name, type: String, desc: 'The name of the member'
        requires :type, type: Integer, desc: 'type of member, 1 for contractor, 2 for employee'
        optional :role, type: String, desc: 'name of role, only for employee'
        optional :duration, type: Integer, desc: 'duration of the contract, only for contractor'
      end
      post do
        member = Member.create!(member_params(params))
        status 201
        present member, with: Api::Entities::Member
      end

      desc 'Delete a member'
      delete '/:id' do
        member = Member.find(params[:id])
        member.destroy!
        status 204
      end
    end
  end
end
