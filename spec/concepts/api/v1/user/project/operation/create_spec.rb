# frozen_string_literal: true

RSpec.describe Api::V1::User::Project::Operation::Create do
  describe '.call' do
    subject(:result) { described_class.call(current_user: user, params: params) }

    let(:user) { create(:user) }

    context 'when params are valid' do
      let(:params) { attributes_for(:project, user: user) }

      it { is_expected.to be_success }
      it { expect { result }.to change(Project, :count).from(0).to(1) }
    end

    context 'when params are invalid' do
      let(:params) { {} }

      it { is_expected.to be_failure }
      it { expect(result['result.contract.default']).to be_failure }
    end
  end
end
