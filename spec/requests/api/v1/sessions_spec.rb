# frozen_string_literal: true

RSpec.describe 'Api::V1::Auth::Sessions', type: :request do
  include Docs::V1::Auth::Session::Api

  describe 'POST /api/v1/auth/sign_in' do
    include Docs::V1::Auth::Session::Create

    before do
      post api_v1_auth_sign_in_path, params: params, as: :json
    end

    context 'when params is valid' do
      let(:user) { create(:user) }
      let(:params) { { email: user.email, password: user.password } }

      it 'returns ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns user', :dox do
        expect(response).to match_schema(Api::V1::UserSchema::Show)
      end
    end

    context 'when params is invalid' do
      let(:user) { attributes_for(:user) }
      let(:params) { { email: user[:email], password: user[:password] } }

      it 'returns unauthorized', :dox do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'DELETE /api/v1/auth/sign_out' do
    include Docs::V1::Auth::Session::Destroy

    let(:user) { create(:user) }
    let(:session_data) { Api::V1::Lib::Operation::GenerateTokens.call(model: user)[:session_data] }

    before do
      delete api_v1_auth_sign_out_path, headers: headers, as: :json
    end

    context 'when access token is valid' do
      let(:headers) do
        { JWTSessions.access_header => "Bearer #{session_data[:access]}",
          JWTSessions.refresh_header => session_data[:refresh] }
      end

      it 'returns ok', :dox do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when headers is invalid' do
      let(:headers) { {} }

      it 'returns unauthorized', :dox do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
