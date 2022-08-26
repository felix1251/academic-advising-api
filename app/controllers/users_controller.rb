class UsersController < ApplicationController
  before_action :authorize_access_request!
  def me
      render json: {details: current_user, account_type: payload["aud"]}
  end
end
