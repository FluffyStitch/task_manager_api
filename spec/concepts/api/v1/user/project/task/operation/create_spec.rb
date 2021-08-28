# frozen_string_literal: true

RSpec.describe Api::V1::User::Project::Task::Operation::Create do
  describe '.call' do
    subject(:result) { described_class.call(current_user: user, params: params) }

    let(:user) { create(:user) }
    let(:project) { create(:project, user: user) }

    context 'when params are valid' do
      let(:params) { attributes_for(:task, project: project).merge({ project_id: project.id }) }

      it { is_expected.to be_success }
      it { expect { result }.to change(Task, :count).from(0).to(1) }
    end

    context 'when params are invalid' do
      let(:params) { {}.merge({ project_id: project.id }) }

      it { is_expected.to be_failure }
      it { expect(result['result.contract.default']).to be_failure }
    end
  end
end
