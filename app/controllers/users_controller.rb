class UsersController < ApplicationController
  before_action :authorize_access_request!

  def me
    if current_user.role == "system_admin"
      render json: current_user, :except=> [:curriculum_id, :college_id, :college_code, :curriculum_code]
    elsif current_user.role == "dean"
      render json: current_user, :except=> [:curriculum_code, :curriculum_id]
    else
      render json: current_user
    end
  end
end
