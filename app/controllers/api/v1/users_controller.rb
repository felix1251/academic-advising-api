class Api::V1::UsersController < ApplicationController

  before_action :authorize_access_request!
  before_action :set_user, only: [:show, :update, :destroy]

  SYSTEM_ADMIN_PARAMS = [:email, :password, :password_confirmation, :fullname, :role].freeze
  DEAN_PARAMS = [:email, :password, :password_confirmation, :fullname, :role, :college_id].freeze
  STUDENT_PARAMS = [:email, :password, :password_confirmation, :fullname, :role, :college_id, :curriculum_id, :id_number].freeze
  ADVISER_PARAMS = [:email, :password, :password_confirmation, :fullname, :role, :college_id, :curriculum_id].freeze
  
  VIEW_ROLES = %w[adviser dean system_admin].freeze
  EDIT_AND_CREATE_ROLES = %w[system_admin].freeze

  def index
    @users = User.joins("LEFT JOIN colleges as c ON c.id = users.college_id
                        LEFT JOIN curriculums as cu ON cu.id = users.curriculum_id")
                        .select('users.id, users.id_number,  users.email, users.role, users.fullname, 
                        users.college_id, users.curriculum_id, c.code AS college_code, cu.code AS curriculum_code')
                               
    if current_user.role == "system_admin"
      @users = @users
    else
      @users = @users.where(role: current_user.role)
    end

    if params[:role].present? && current_user.role == "system_admin"
      @users = @users.where(role: params[:role])
    end
    render json: @users
  end

  def search_student
    if params[:id_number].present?
      _user = User.joins("LEFT JOIN colleges as c ON c.id = users.college_id
          LEFT JOIN curriculums as cu ON cu.id = users.curriculum_id")
          .select('users.id, users.id_number,  users.email, users.role, users.fullname, 
          users.college_id, users.curriculum_id, c.code AS college_code, cu.code AS curriculum_code')
          .where('users.id_number = ? or users.role = ?', params[:id_number], "student").first
    elsif
      render json: {result: "params empty"}, status: :unprocessable_entity
    end

    if _user
      render json: _user
    elsif
      render json: {result: "no student data found"}, status: :unprocessable_entity
    end
  end

  def show
    render json: @user
  end

  def create
    @user= User.new(user_create_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    @user.update!(user_update_params)
    JWTSessions::Session.new(namespace: "user_#{@user.id}").flush_namespaced_access_tokens
    render json: @user
  end

  def destroy
    @user.destroy
  end


  def show_roles
    render json: {data: ["student", "adviser", "dean", "system_admin"]}
  end

  def token_claims
    {
      aud: allowed_aud,
      verify_aud: true
    }
  end

  private

  def allowed_aud
    if action_name == 'create' || action_name == 'destroy' || action_name == 'show_roles' || action_name == 'update' || action_name == "search_student"
      EDIT_AND_CREATE_ROLES
    else
      VIEW_ROLES
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_update_params
    params.require(:user).permit(:role)
  end

  def user_create_params
    if params[:role] == 'student'
      params.tap { |p| p.require(STUDENT_PARAMS) }.permit(*STUDENT_PARAMS)
    elsif params[:role] == 'adviser'
      params.tap { |p| p.require(ADVISER_PARAMS) }.permit(*ADVISER_PARAMS)
    elsif params[:role] == 'dean'
      params.tap { |p| p.require(DEAN_PARAMS) }.permit(*DEAN_PARAMS)
    else
      params.tap { |p| p.require(SYSTEM_ADMIN_PARAMS) }.permit(*SYSTEM_ADMIN_PARAMS)
    end
  end
end
