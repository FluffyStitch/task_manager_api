# frozen_string_literal: true

RSpec.describe 'Api::V1::Comments', type: :request do
  include Docs::V1::Comment::Api

  let(:user) { create(:user) }
  let(:session_data) { Api::V1::Lib::Operation::GenerateTokens.call(model: user)[:session_data] }
  let(:headers) { { JWTSessions.access_header => "Bearer #{session_data[:access]}" } }
  let(:task) { create(:task, project: create(:project, user: user)) }
  let!(:comments) { create_list(:comment, 3, task: task) }

  describe 'GET /api/v1/tasks/{task_id}/comments' do
    include Docs::V1::Comment::Index

    before do
      get api_v1_task_comments_path(task), headers: headers, as: :json
    end

    it 'returns ok' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns comments', :dox do
      expect(response).to match_schema(Api::V1::CommentSchema::Index)
    end
  end

  describe 'POST /api/v1/tasks/{task_id}/comments' do
    include Docs::V1::Comment::Create

    before do
      post api_v1_task_comments_path(task), params: params, headers: headers, as: :json
    end

    context 'when params is valid' do
      let(:params) { create(:comment, task: task) }

      it 'returns created' do
        expect(response).to have_http_status(:created)
      end

      it 'returns comment', :dox do
        expect(response).to match_schema(Api::V1::CommentSchema::Show)
      end
    end

    context 'when params is invalid' do
      let(:params) { create(:comment, text: '', task: task) }

      it 'returns unprocessable entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns errors', :dox do
        expect(response).to match_schema(Api::V1::ErrorSchema)
      end
    end
  end

  describe 'DELETE /api/v1/comments/{id}' do
    include Docs::V1::Comment::Destroy

    before do
      delete api_v1_comment_path(comments.first), headers: headers, as: :json
    end

    context 'when comment exists' do
      it 'returns no content', :dox do
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when comment does not exist' do
      let(:comments) { create_list(:comment, 2) }

      it 'returns not found', :dox do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
