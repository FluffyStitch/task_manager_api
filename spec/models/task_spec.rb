# frozen_string_literal: true

RSpec.describe Task, type: :model do
  it { is_expected.to have_db_column(:text) }
  it { is_expected.to have_db_column(:deadline) }
  it { is_expected.to have_db_column(:position) }
  it { is_expected.to have_db_column(:completed) }
  it { is_expected.to have_db_column(:project_id) }
  it { is_expected.to belong_to(:project) }
  it { is_expected.to have_many(:comments).dependent(:destroy) }
  it { is_expected.to have_db_index(:project_id) }
end
