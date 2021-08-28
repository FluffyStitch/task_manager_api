# frozen_string_literal: true

RSpec.describe Api::V1::User::Project::Operation::Index do
  describe '.call' do
    subject(:result) { described_class.call(current_user: user, params: params) }

    let(:user) { create(:user) }
    let(:params) { {} }

    before { create_list(:project, 3, user: user) }

    context 'when params are valid' do
      it { is_expected.to be_success }
    end

    context 'when pagination params are present' do
      let(:size) { 1 }
      let(:params) { { page: { size: size } } }

      it { is_expected.to be_success }
      it { expect(result[:model].count).to eq size }
    end

    context 'when pagination params are invalid' do
      let(:params) { { page: { number: -1 } } }

      it { is_expected.to be_failure }
      it { expect(result['result.contract.uri_query'].errors).not_to be_empty }
    end
  end
end
