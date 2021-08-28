# frozen_string_literal: true

RSpec.describe Api::V1::User::Project::Task::Comment::Contract::Create do
  subject(:contract) { described_class.new(Comment.new(task_id: task.id)) }

  let(:task) { create(:task) }

  before { contract.validate(params) }

  describe 'when params is valid' do
    let(:params) { attributes_for(:comment) }

    context 'when whithout images' do
      it { expect(contract.errors).to be_empty }
    end

    context 'when with images' do
      let(:params) do
        attributes_for(:comment).merge(
          images: [
            { image: Rack::Test::UploadedFile.new('spec/fixtures/images/unicorn.png', 'image/jpeg') }
          ]
        )
      end

      it { expect(contract.errors).to be_empty }
    end
  end

  describe 'when params is invalid' do
    let(:params) { attributes_for(:comment, text: '') }

    it { expect(contract.errors).not_to be_empty }
  end
end
