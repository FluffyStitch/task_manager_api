# frozen_string_literal: true

RSpec.describe Api::V1::User::Project::Task::Operation::Complete do
  describe '.call' do
    subject(:result) { described_class.call(current_user: user, params: params) }

    let(:user) { create(:user) }
    let!(:task) { create(:task, project: create(:project, user: user)) }

    context 'when params are valid' do
      let(:params) { { task_id: task.id } }

      it { is_expected.to be_success }
    end

    context 'when task does not exist' do
      let(:params) { { id: task.id + 1 } }

      it { is_expected.to be_failure }
      it { expect(result[:status]).to eq :not_found }
    end
  end
end
