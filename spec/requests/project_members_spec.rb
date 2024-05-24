# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Projects::MembersController, type: :request do
  let!(:project) { create(:project) }
  let!(:members) { create_list(:member, 3) }
  let!(:member_projects) do
    members.each do |member|
      create(:member_project, member:, project:)
    end
  end

  def json_response
    response.parsed_body
  end

  describe 'GET #index' do
    before { get "/api/v1/projects/#{project.id}/members", headers: { 'ACCEPT' => 'application/json' } }

    it 'returns all members of the project' do
      expect(json_response).not_to be_empty
      expect(json_response['members'].size).to eq(3)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end
  end
end
