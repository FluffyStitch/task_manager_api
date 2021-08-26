# frozen_string_literal: true

RSpec.describe Project, type: :model do
  it { is_expected.to have_db_column(:name) }
  it { is_expected.to have_db_column(:user_id) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:tasks).dependent(:destroy) }
  it { is_expected.to have_db_index(:user_id) }
end
