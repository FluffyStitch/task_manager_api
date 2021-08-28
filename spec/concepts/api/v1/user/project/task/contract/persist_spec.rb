# frozen_string_literal: true

RSpec.describe Api::V1::User::Project::Task::Contract::Persist do
  subject(:contract) { described_class.new(Task.new(project_id: project.id)) }

  let(:project) { create(:project) }

  before { contract.validate(params) }

  describe 'when params is valid' do
    let(:params) { attributes_for(:task, project: project) }

    it { expect(contract.errors).to be_empty }
  end

  describe 'when params is invalid' do
    let(:params) { attributes_for(:task, project: project, deadline: FFaker::AnimalUS.common_name) }

    it { expect(contract.errors).not_to be_empty }
  end
end
