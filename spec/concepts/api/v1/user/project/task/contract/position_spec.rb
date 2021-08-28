# frozen_string_literal: true

RSpec.describe Api::V1::User::Project::Task::Contract::Position do
  subject(:contract) { described_class.new(Task.new(project_id: project.id)) }

  let(:project) { create(:project) }

  before { contract.validate(params) }

  describe 'when params is valid' do
    context 'when position up' do
      let(:params) { { position: 'up' } }

      it { expect(contract.errors).to be_empty }
    end

    context 'when position down' do
      let(:params) { { position: 'down' } }

      it { expect(contract.errors).to be_empty }
    end
  end

  describe 'when params is invalid' do
    let(:params) { { position: FFaker::AnimalUS.common_name } }

    it { expect(contract.errors).not_to be_empty }
  end
end
