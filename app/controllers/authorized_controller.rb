# frozen_string_literal: true

class AuthorizedController < ApplicationController
  before_action :authorize_access_request!

  private

  def current_user
    User.find_by(id: payload['id']) || raise(JWTSessions::Errors::Unauthorized)
  end

  def endpoint_options
    super.merge(current_user: current_user)
  end
end
