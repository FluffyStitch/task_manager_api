# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :projects, dependent: :destroy
  has_many :tasks, through: :projects
  has_many :comments, through: :tasks
  has_many :images, through: :comments
end
