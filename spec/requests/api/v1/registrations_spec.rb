# frozen_string_literal: true

RSpec.describe 'Api::V1::Auth::Registrations', type: :request do
  include Docs::V1::Auth::Registration::Api

  describe 'POST /api/v1/auth' do
    include Docs::V1::Auth::Registration::Create

    before do
      post api_v1_auth_path, params: params, as: :json
    end

    context 'when params is valid' do
      let(:params) { attributes_for(:user) }

      it 'returns created' do
        expect(response).to have_http_status(:created)
      end

      it 'returns user', :dox do
        expect(response).to match_schema(Api::V1::UserSchema::Show)
      end
    end

    context 'when params is invalid' do
      let(:params) { {} }

      it 'returns unprocessable entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns error', :dox do
        expect(response).to match_schema(Api::V1::ErrorSchema)
      end
    end
  end
end
