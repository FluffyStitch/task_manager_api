# frozen_string_literal: true

RSpec.describe Api::V1::User::Project::Task::Comment::Operation::Destroy do
  describe '.call' do
    subject(:result) { described_class.call(current_user: user, params: params) }

    let(:user) { create(:user) }
    let!(:comment) { create(:comment, task: create(:task, project: create(:project, user: user))) }

    context 'when params are valid' do
      let(:params) { { id: comment.id } }

      it { is_expected.to be_success }
      it { expect { result }.to change(Comment, :count).from(1).to(0) }
    end

    context 'when params are invalid' do
      let(:params) { {} }

      it { is_expected.to be_failure }
      it { expect(result[:status]).to eq :not_found }
    end
  end
end
