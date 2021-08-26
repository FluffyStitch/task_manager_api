# frozen_string_literal: true

module Api::V1
  module Auth
    class RegistrationsController < ApplicationController
      def create
        endpoint operation: Api::V1::User::Registration::Operation::Create
      end
    end
  end
end
