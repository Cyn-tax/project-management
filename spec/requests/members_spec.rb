# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::MembersController, type: :request do
  let!(:team) { create(:team) }
  let!(:member) { create(:member, team:) }

  def json_response
    response.parsed_body
  end

  describe 'GET #index' do
    before { get '/api/v1/members', headers: { 'ACCEPT' => 'application/json' } }

    it 'returns all members' do
      expect(json_response).not_to be_empty
      expect(json_response.size).to eq(1)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #show' do
    before { get "/api/v1/members/#{member.id}", headers: { 'ACCEPT' => 'application/json' } }

    it 'returns the member' do
      expect(json_response).not_to be_empty
      expect(json_response['member']['id']).to eq(member.id)
      expect(json_response['member']['first_name']).to eq(member.first_name)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST #create' do
    context 'when request is valid' do
      let(:valid_attributes) do
        { member: { first_name: 'John', last_name: 'Doe', city: 'New York', state: 'NY', country: 'USA',
                    team_id: team.id } }
      end
      before { post '/api/v1/members', params: valid_attributes, headers: { 'ACCEPT' => 'application/json' } }

      it 'creates a new member' do
        expect(json_response['member']['first_name']).to eq('John')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when request is invalid' do
      before do
        post '/api/v1/members', params: { member: { first_name: '' } }, headers: { 'ACCEPT' => 'application/json' }
      end

      it 'does not create a new member' do
        expect(Member.count).to eq(1) # Only the initial member should exist
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    context 'when request is valid' do
      let(:valid_attributes) { { member: { first_name: 'Jane' } } }
      before do
        put "/api/v1/members/#{member.id}", params: valid_attributes, headers: { 'ACCEPT' => 'application/json' }
      end

      it 'updates the member' do
        expect(json_response['member']['first_name']).to eq('Jane')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when request is invalid' do
      before do
        put "/api/v1/members/#{member.id}", params: { member: { first_name: '' } },
                                            headers: { 'ACCEPT' => 'application/json' }
      end

      it 'does not update the member' do
        expect(member.reload.first_name).to eq(member.first_name) # The member's first name should remain unchanged
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    before { delete "/api/v1/members/#{member.id}", headers: { 'ACCEPT' => 'application/json' } }

    it 'deletes the member' do
      expect(Member.count).to eq(0) # The member should be deleted
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(:no_content)
    end
  end
end
