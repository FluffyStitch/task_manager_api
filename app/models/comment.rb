# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :task
  has_many :images, dependent: :destroy
end
