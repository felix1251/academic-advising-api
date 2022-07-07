class Api::V1::CountsController < ApplicationController
  before_action :authorize_access_request!
  VIEW_ROLES = %w[adviser dean system_admin].freeze

  def count
    @colleges = College.count
    @curriculum = Curriculum.count
    @subjects = Subject.count
    @department = Department.count
    if current_user.role == "system_admin"
      @user = User.count
      render json: {user_count: @user, college_count: @colleges, curriculum_count: @curriculum, subject_count: @subjects, department_count: @department }
    else
      render json: {college_count: @colleges, curriculum_count: @curriculum, subject_count: @subjects, department_count: @department }
    end
  end

  def token_claims
    {
      aud: VIEW_ROLES,
      verify_aud: true
    }
  end
  
end
  