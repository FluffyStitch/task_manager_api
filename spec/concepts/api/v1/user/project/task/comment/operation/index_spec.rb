# frozen_string_literal: true

RSpec.describe Api::V1::User::Project::Task::Comment::Operation::Index do
  describe '.call' do
    subject(:result) { described_class.call(current_user: user, params: params) }

    let(:user) { create(:user) }
    let(:task) { create(:task, project: create(:project, user: user)) }

    before { create_list(:comment, 3, task: task) }

    context 'when params are valid' do
      let(:params) { { task_id: task.id } }

      it { is_expected.to be_success }
    end
  end
end
