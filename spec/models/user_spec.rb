# frozen_string_literal: true

RSpec.describe User, type: :model do
  it { is_expected.to have_db_column(:email) }
  it { is_expected.to have_db_column(:password_digest) }
  it { is_expected.to have_db_index(:email) }
  it { is_expected.to have_many(:projects).dependent(:destroy) }
  it { is_expected.to have_many(:tasks).through(:projects) }
  it { is_expected.to have_many(:comments).through(:tasks) }
  it { is_expected.to have_many(:images).through(:comments) }
end
