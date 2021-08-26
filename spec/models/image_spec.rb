# frozen_string_literal: true

RSpec.describe Image, type: :model do
  it { is_expected.to have_db_column(:image_data) }
  it { is_expected.to have_db_column(:comment_id) }
  it { is_expected.to belong_to(:comment) }
  it { is_expected.to have_db_index(:comment_id) }
end
