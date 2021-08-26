# frozen_string_literal: true

RSpec.describe Comment, type: :model do
  it { is_expected.to have_db_column(:text) }
  it { is_expected.to have_db_column(:task_id) }
  it { is_expected.to belong_to(:task) }
  it { is_expected.to have_many(:images).dependent(:destroy) }
  it { is_expected.to have_db_index(:task_id) }
end
