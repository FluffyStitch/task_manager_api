# frozen_string_literal: true

RSpec.describe Api::V1::User::Project::Task::Operation::Index do
  describe '.call' do
    subject(:result) { described_class.call(current_user: user, params: params) }

    let(:user) { create(:user) }
    let(:project) { create(:project, user: user) }

    before { create_list(:task, 3, project: project) }

    context 'when params are valid' do
      let(:params) { { project_id: project.id } }

      it { is_expected.to be_success }
    end

    context 'when filtration by completed' do
      let(:params) { { project_id: project.id, filter: { 'completed-true' => '1' } } }

      it { is_expected.to be_success }
      it { expect(result[:model].count).to eq 0 }
    end

    context 'when filtration by not completed' do
      let(:params) { { project_id: project.id, filter: { 'completed-true' => '0' } } }

      it { is_expected.to be_success }
      it { expect(result[:model].count).to eq 3 }
    end

    context 'when filtration params are invalid' do
      let(:params) { { project_id: project.id, filter: { 'completed-true' => '2' } } }

      it { is_expected.to be_failure }
      it { expect(result['result.contract.uri_query'].errors).not_to be_empty }
    end
  end
end
