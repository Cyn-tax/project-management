# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ProjectsController, type: :request do
  let!(:project) { create(:project, name: 'Test Project') }

  def json_response
    response.parsed_body
  end

  describe 'GET #index' do
    before { get '/api/v1/projects', headers: { 'ACCEPT' => 'application/json' } }

    it 'returns all projects' do
      expect(json_response).not_to be_empty
      expect(json_response.size).to eq(1)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #show' do
    before { get "/api/v1/projects/#{project.id}", headers: { 'ACCEPT' => 'application/json' } }

    it 'returns the project' do
      expect(json_response).not_to be_empty
      expect(json_response['project']['id']).to eq(project.id)
      expect(json_response['project']['name']).to eq('Test Project')
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST #create' do
    context 'when request is valid' do
      before do
        post '/api/v1/projects', params: { project: { name: 'New Project' } },
                                 headers: { 'ACCEPT' => 'application/json' }
      end

      it 'creates a new project' do
        expect(json_response['project']['name']).to eq('New Project')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when request is invalid' do
      before { post '/api/v1/projects', params: { project: { name: '' } }, headers: { 'ACCEPT' => 'application/json' } }

      it 'does not create a new project' do
        expect(Project.count).to eq(1) # Only the initial project should exist
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    context 'when request is valid' do
      before do
        put "/api/v1/projects/#{project.id}", params: { project: { name: 'Updated Project' } },
                                              headers: { 'ACCEPT' => 'application/json' }
      end

      it 'updates the project' do
        expect(json_response['project']['name']).to eq('Updated Project')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when request is invalid' do
      before do
        put "/api/v1/projects/#{project.id}", params: { project: { name: '' } },
                                              headers: { 'ACCEPT' => 'application/json' }
      end

      it 'does not update the project' do
        expect(project.reload.name).to eq('Test Project') # The project name should remain unchanged
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    before { delete "/api/v1/projects/#{project.id}", headers: { 'ACCEPT' => 'application/json' } }

    it 'deletes the project' do
      expect(Project.count).to eq(0) # The project should be deleted
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(:no_content)
    end
  end
end
