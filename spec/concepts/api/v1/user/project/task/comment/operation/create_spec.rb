# frozen_string_literal: true

RSpec.describe Api::V1::User::Project::Task::Comment::Operation::Create do
  describe '.call' do
    subject(:result) { described_class.call(current_user: user, params: params) }

    let(:user) { create(:user) }
    let(:task) { create(:task, project: create(:project, user: user)) }

    context 'when params are valid' do
      let(:params) { attributes_for(:comment, task: task).merge({ task_id: task.id }) }

      it { is_expected.to be_success }
      it { expect { result }.to change(Comment, :count).from(0).to(1) }
    end

    context 'when params are invalid' do
      let(:params) { {}.merge({ task_id: task.id }) }

      it { is_expected.to be_failure }
      it { expect(result['result.contract.default']).to be_failure }
    end
  end
end
