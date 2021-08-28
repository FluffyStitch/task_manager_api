# frozen_string_literal: true

RSpec.describe 'Api::V1::Projects', type: :request do
  include Docs::V1::Project::Api

  let(:user) { create(:user) }
  let(:session_data) { Api::V1::Lib::Operation::GenerateTokens.call(model: user)[:session_data] }
  let(:headers) { { JWTSessions.access_header => "Bearer #{session_data[:access]}" } }
  let!(:projects) { create_list(:project, 3, user: user) }

  describe 'GET /api/v1/projects' do
    include Docs::V1::Project::Index

    before do
      get api_v1_projects_path, headers: headers, as: :json
    end

    it 'returns ok' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns projects', :dox do
      expect(response).to match_schema(Api::V1::ProjectSchema::Index)
    end
  end

  describe 'POST /api/v1/projects' do
    include Docs::V1::Project::Create

    before do
      post api_v1_projects_path, params: params, headers: headers, as: :json
    end

    context 'when params is valid' do
      let(:params) { attributes_for(:project, user: user) }

      it 'returns created' do
        expect(response).to have_http_status(:created)
      end

      it 'returns project', :dox do
        expect(response).to match_schema(Api::V1::ProjectSchema::Show)
      end
    end

    context 'when params is invalid' do
      let(:params) { { name: '' } }

      it 'returns unprocessable entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns errors', :dox do
        expect(response).to match_schema(Api::V1::ErrorSchema)
      end
    end
  end

  describe 'GET /api/v1/projects/{id}' do
    include Docs::V1::Project::Show

    before do
      get api_v1_project_path(projects.first), headers: headers, as: :json
    end

    it 'returns ok' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns project', :dox do
      expect(response).to match_schema(Api::V1::ProjectSchema::Show)
    end
  end

  describe 'PATCH /api/v1/projects/{id}' do
    include Docs::V1::Project::Update

    before do
      patch api_v1_project_path(projects.first), params: params, headers: headers, as: :json
    end

    context 'when params is valid' do
      let(:params) { attributes_for(:project, user: user) }

      it 'returns created' do
        expect(response).to have_http_status(:created)
      end

      it 'returns project', :dox do
        expect(response).to match_schema(Api::V1::ProjectSchema::Show)
      end
    end

    context 'when params is invalid' do
      let(:params) { { name: '' } }

      it 'returns unprocessable entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns errors', :dox do
        expect(response).to match_schema(Api::V1::ErrorSchema)
      end
    end
  end

  describe 'DELETE /api/v1/projects/{id}' do
    include Docs::V1::Project::Destroy

    before do
      delete api_v1_project_path(projects.first), headers: headers, as: :json
    end

    context 'when project exists' do
      it 'returns no content', :dox do
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when project does not exist' do
      let(:projects) { create_list(:project, 2) }

      it 'returns not found', :dox do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
