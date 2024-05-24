# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Teams::MembersController, type: :request do
  let!(:team) { create(:team) }
  let!(:members) { create_list(:member, 3, team:) }

  def json_response
    response.parsed_body
  end

  describe 'GET #index' do
    before { get "/api/v1/teams/#{team.id}/members", headers: { 'ACCEPT' => 'application/json' } }

    it 'returns all members of the team' do
      expect(json_response).not_to be_empty
      expect(json_response['members'].size).to eq(3)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end
  end
end
