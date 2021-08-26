# frozen_string_literal: true

RSpec.describe Api::V1::User::Project::Operation::Update do
  describe '.call' do
    subject(:result) { described_class.call(current_user: user, params: params) }

    let(:user) { create(:user) }
    let!(:project) { create(:project, user: user) }

    context 'when params are valid' do
      let(:params) { attributes_for(:project, user: user).merge({ id: project.id }) }

      it { is_expected.to be_success }
    end

    context 'when params are invalid' do
      let(:params) { attributes_for(:project, name: '', user: user).merge({ id: project.id }) }

      it { is_expected.to be_failure }
      it { expect(result['result.contract.default']).to be_failure }
    end

    context 'when project does not exist' do
      let(:params) { { id: project.id + 1 } }

      it { is_expected.to be_failure }
      it { expect(result[:status]).to eq :not_found }
    end
  end
end
