# frozen_string_literal: true

RSpec.describe Api::V1::User::Project::Task::Operation::Update do
  describe '.call' do
    subject(:result) { described_class.call(current_user: user, params: params) }

    let(:user) { create(:user) }
    let(:project) { create(:project, user: user) }
    let!(:task) { create(:task, project: project) }

    context 'when params are valid' do
      let(:params) { attributes_for(:task, project: project).merge({ id: task.id }) }

      it { is_expected.to be_success }
    end

    context 'when params are invalid' do
      let(:params) { attributes_for(:task, text: '', project: project).merge({ id: task.id }) }

      it { is_expected.to be_failure }
      it { expect(result['result.contract.default']).to be_failure }
    end

    context 'when task does not exist' do
      let(:params) { { id: task.id + 1 } }

      it { is_expected.to be_failure }
      it { expect(result[:semantic_failure]).to eq :not_found }
    end
  end
end
