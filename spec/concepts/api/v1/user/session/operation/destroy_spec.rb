# frozen_string_literal: true

RSpec.describe Api::V1::User::Session::Operation::Destroy do
  describe '.call' do
    subject(:result) { described_class.call(refresh_token: session_data[:refresh]) }

    let(:user) { create(:user) }
    let(:session_data) { Api::V1::Lib::Operation::GenerateTokens.call(model: user)[:session_data] }

    context 'when params are valid' do
      it { is_expected.to be_success }
    end
  end
end
