# frozen_string_literal: true

RSpec.describe Api::V1::User::Registration::Contract::Create do
  subject(:contract) { described_class.new(User.new) }

  before { contract.validate(params) }

  describe 'when params is valid' do
    let(:params) { attributes_for(:user) }

    it { expect(contract.errors).to be_empty }
  end

  describe 'when params is invalid' do
    let(:params) { attributes_for(:user, email: '') }

    it { expect(contract.errors).not_to be_empty }
  end

  describe 'when password confirmation does not match password' do
    let(:params) { attributes_for(:user, password_confirmation: '') }

    before { contract.validate(params) }

    it { expect(contract.errors[:password_confirmation]).not_to be_empty }
  end
end
