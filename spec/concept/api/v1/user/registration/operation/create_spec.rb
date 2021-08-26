# frozen_string_literal: true

RSpec.describe Api::V1::User::Registration::Operation::Create do
  describe '.call' do
    subject(:result) { described_class.call(params: params) }

    context 'when params are valid' do
      let(:params) { attributes_for(:user) }

      it { is_expected.to be_success }
      it { expect { result }.to change(User, :count).from(0).to(1) }
    end

    context 'when params are invalid' do
      let(:params) { {} }

      it { is_expected.to be_failure }
      it { expect(result['result.contract.default']).to be_failure }
    end
  end
end
