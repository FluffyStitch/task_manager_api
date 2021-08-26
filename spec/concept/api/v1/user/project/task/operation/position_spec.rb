# frozen_string_literal: true

RSpec.describe Api::V1::User::Project::Task::Operation::Position do
  describe '.call' do
    subject(:result) { described_class.call(current_user: user, params: params) }

    let(:user) { create(:user) }
    let(:project) { create(:project, user: user) }
    let!(:tasks) { create_list(:task, 3, project: project) }

    context 'when move down' do
      let(:params) { { task_id: tasks.first.id, position: 'down' } }

      it { is_expected.to be_success }
    end

    context 'when move up' do
      let(:params) { { task_id: tasks.last.id, position: 'up' } }

      it { is_expected.to be_success }
    end

    context 'when params are invalid' do
      let(:params) { { task_id: tasks.last.id, position: FFaker::AnimalUS.common_name } }

      it { is_expected.to be_failure }
      it { expect(result['result.contract.default']).to be_failure }
    end

    context 'when task does not exist' do
      let(:params) { { id: tasks.last.id + 1 } }

      it { is_expected.to be_failure }
      it { expect(result[:status]).to eq :not_found }
    end
  end
end
