# frozen_string_literal: true

RSpec.describe Api::V1::User::Project::Contract::Persist do
  subject(:contract) { described_class.new(Project.new(user_id: user.id)) }

  let(:user) { create(:user) }

  before { contract.validate(params) }

  describe 'when params is valid' do
    let(:params) { attributes_for(:project) }

    it { expect(contract.errors).to be_empty }
  end

  describe 'when params is invalid' do
    let!(:project) { create(:project, user: user) }
    let(:params) { attributes_for(:project, name: project.name, user: user) }

    it { expect(contract.errors).not_to be_empty }
  end
end
