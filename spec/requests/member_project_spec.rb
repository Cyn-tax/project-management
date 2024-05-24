# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::MemberProjectsController, type: :request do
  let!(:member) { create(:member) }
  let!(:project) { create(:project) }

  def json_response
    response.parsed_body
  end

  describe 'POST #create' do
    context 'when request is valid' do
      let(:valid_attributes) { { member_project: { member_id: member.id, project_id: project.id } } }
      before { post '/api/v1/member_projects', params: valid_attributes, headers: { 'ACCEPT' => 'application/json' } }

      it 'creates a new member_project' do
        expect(json_response['member_id']).to eq(member.id)
        expect(json_response['project_id']).to eq(project.id)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when request is dublicated' do
      before do
        post '/api/v1/member_projects', params: { member_project: { member_id: member.id, project_id: project.id } },
                                        headers: { 'ACCEPT' => 'application/json' }
      end
      before do
        post '/api/v1/member_projects', params: { member_project: { member_id: member.id, project_id: project.id } },
                                        headers: { 'ACCEPT' => 'application/json' }
      end

      it 'does not create a new member_project' do
        expect(MemberProject.count).to eq(1) # Only 1 member_project should be created
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when request is invalid' do
      before do
        post '/api/v1/member_projects', params: { member_project: { member_id: nil, project_id: nil } },
                                        headers: { 'ACCEPT' => 'application/json' }
      end

      it 'does not create a new member_project' do
        expect(MemberProject.count).to eq(0) # No member_project should be created
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
