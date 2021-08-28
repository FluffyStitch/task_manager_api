# frozen_string_literal: true

RSpec.describe 'Api::V1::Tasks', type: :request do
  include Docs::V1::Task::Api

  let(:user) { create(:user) }
  let(:session_data) { Api::V1::Lib::Operation::GenerateTokens.call(model: user)[:session_data] }
  let(:headers) { { JWTSessions.access_header => "Bearer #{session_data[:access]}" } }
  let(:project) { create(:project, user: user) }
  let!(:tasks) { create_list(:task, 3, project: project) }

  describe 'GET /api/v1/projects/{id}/tasks' do
    include Docs::V1::Task::Index

    before do
      get api_v1_project_tasks_path(project), headers: headers, as: :json
    end

    it 'returns ok' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns tasks', :dox do
      expect(response).to match_schema(Api::V1::TaskSchema::Index)
    end
  end

  describe 'POST /api/v1/projects/{project_id}/tasks' do
    include Docs::V1::Task::Create

    before do
      post api_v1_project_tasks_path(project), params: params, headers: headers, as: :json
    end

    context 'when params is valid' do
      let(:params) { attributes_for(:task, project: project) }

      it 'returns created' do
        expect(response).to have_http_status(:created)
      end

      it 'returns task', :dox do
        expect(response).to match_schema(Api::V1::TaskSchema::Show)
      end
    end

    context 'when params is invalid' do
      let(:params) { attributes_for(:task, text: '') }

      it 'returns unprocessable entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns errors', :dox do
        expect(response).to match_schema(Api::V1::ErrorSchema)
      end
    end
  end

  describe 'GET /api/v1/task/{id}' do
    include Docs::V1::Task::Show

    before do
      get api_v1_task_path(tasks.first), headers: headers, as: :json
    end

    it 'returns ok' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns task', :dox do
      expect(response).to match_schema(Api::V1::TaskSchema::Show)
    end
  end

  describe 'PATCH /api/v1/task/{id}' do
    include Docs::V1::Task::Update

    before do
      patch api_v1_task_path(tasks.first), params: params, headers: headers, as: :json
    end

    context 'when params is valid' do
      let(:params) { attributes_for(:task, project: project) }

      it 'returns created' do
        expect(response).to have_http_status(:created)
      end

      it 'returns task', :dox do
        expect(response).to match_schema(Api::V1::TaskSchema::Show)
      end
    end

    context 'when params is invalid' do
      let(:params) { attributes_for(:task, text: '') }

      it 'returns http unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns errors', :dox do
        expect(response).to match_schema(Api::V1::ErrorSchema)
      end
    end
  end

  describe 'DELETE /api/v1/tasks/{id}' do
    include Docs::V1::Task::Destroy

    before do
      delete api_v1_task_path(tasks.first), headers: headers, as: :json
    end

    context 'when task exists' do
      it 'returns no content', :dox do
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when task does not exist' do
      let(:tasks) { create_list(:task, 2) }

      it 'returns not found', :dox do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'PATCH /api/v1/task/{task_id}/complete' do
    include Docs::V1::Task::Complete

    before do
      patch api_v1_task_complete_path(tasks.first), headers: headers, as: :json
    end

    it 'returns created' do
      expect(response).to have_http_status(:created)
    end

    it 'returns task', :dox do
      expect(response).to match_schema(Api::V1::TaskSchema::Show)
    end
  end

  describe 'PATCH /api/v1/task/{task_id}/position' do
    include Docs::V1::Task::Position

    context 'when move down' do
      let(:params) { { position: 'down' } }

      before do
        patch api_v1_task_position_path(tasks.first), params: params, headers: headers, as: :json
      end

      it 'returns created' do
        expect(response).to have_http_status(:created)
      end

      it 'returns task', :dox do
        expect(response).to match_schema(Api::V1::TaskSchema::Show)
      end
    end

    context 'when move up' do
      let(:params) { { position: 'up' } }

      before do
        patch api_v1_task_position_path(tasks.last), params: params, headers: headers, as: :json
      end

      it 'returns created' do
        expect(response).to have_http_status(:created)
      end

      it 'returns task', :dox do
        expect(response).to match_schema(Api::V1::TaskSchema::Show)
      end
    end

    context 'when params is invalid' do
      let(:params) { { position: -1 } }

      before do
        patch api_v1_task_position_path(tasks.first), params: params, headers: headers, as: :json
      end

      it 'returns unprocessable entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns errors', :dox do
        expect(response).to match_schema(Api::V1::ErrorSchema)
      end
    end
  end
end
