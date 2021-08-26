# frozen_string_literal: true

module Api::V1
  class UserSerializer < Api::V1::ApplicationSerializer
    attribute :email
  end
end
