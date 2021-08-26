# frozen_string_literal: true

RSpec.describe Api::V1::User::Session::Operation::Create do
  describe '.call' do
    subject(:result) { described_class.call(params: params) }

    let(:user) { create(:user) }

    context 'when params are valid' do
      let(:params) { { email: user.email, password: user.password } }

      it { is_expected.to be_success }
    end

    context 'when params are invalid' do
      let(:params) { {} }

      it { is_expected.to be_failure }
      it { expect(result[:status]).to eq :unauthorized }
    end
  end
end
