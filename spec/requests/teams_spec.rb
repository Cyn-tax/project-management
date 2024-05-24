# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::TeamsController, type: :request do
  let!(:team) { create(:team, name: 'Test Team') }

  def json_response
    response.parsed_body
  end

  describe 'GET #index' do
    before { get '/api/v1/teams', headers: { 'ACCEPT' => 'application/json' } }

    it 'returns all teams' do
      expect(json_response).not_to be_empty
      expect(json_response.size).to eq(1)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #show' do
    context 'when request is valid' do
      before { get "/api/v1/teams/#{team.id}", headers: { 'ACCEPT' => 'application/json' } }

      it 'returns the team' do
        expect(json_response).not_to be_empty
        expect(json_response['team']['id']).to eq(team.id)
        expect(json_response['team']['name']).to eq('Test Team')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end
    end
    context 'when request is in_valid' do
      before { get '/api/v1/teams/test', headers: { 'ACCEPT' => 'application/json' } }

      it 'returns status code 404' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST #create' do
    context 'when request is valid' do
      before do
        post '/api/v1/teams', params: { team: { name: 'New Team' } }, headers: { 'ACCEPT' => 'application/json' }
      end

      it 'creates a new team' do
        expect(json_response['team']['name']).to eq('New Team')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when request is invalid' do
      before { post '/api/v1/teams', params: { team: { name: '' } }, headers: { 'ACCEPT' => 'application/json' } }

      it 'does not create a new team' do
        expect(Team.count).to eq(1) # Only the initial team should exist
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when param is missing' do
      before { post '/api/v1/teams', params: {}, headers: { 'ACCEPT' => 'application/json' } }

      it 'does not create a new team' do
        expect(Team.count).to eq(1) # Only the initial team should exist
      end

      it 'returns status code 406' do
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'PUT #update' do
    context 'when request is valid' do
      before do
        put "/api/v1/teams/#{team.id}", params: { team: { name: 'Updated Team' } },
                                        headers: { 'ACCEPT' => 'application/json' }
      end

      it 'updates the team' do
        expect(json_response['team']['name']).to eq('Updated Team')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when request is invalid' do
      before do
        put "/api/v1/teams/#{team.id}", params: { team: { name: '' } }, headers: { 'ACCEPT' => 'application/json' }
      end

      it 'does not update the team' do
        expect(team.reload.name).to eq('Test Team') # The team name should remain unchanged
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    before { delete "/api/v1/teams/#{team.id}", headers: { 'ACCEPT' => 'application/json' } }

    it 'deletes the team' do
      expect(Team.count).to eq(0) # The team should be deleted
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(:no_content)
    end
  end
end
