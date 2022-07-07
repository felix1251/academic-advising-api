class Api::V1::DepartmentsController < ApplicationController
  before_action :authorize_access_request!
  before_action :set_department, only: [:show, :update, :destroy]
  VIEW_ROLES = %w[adviser dean system_admin].freeze
  EDIT_AND_CREATE_ROLES = %w[system_admin].freeze

  # GET /departments
  def index
    @departments = Department.joins("LEFT JOIN colleges as c ON c.id = departments.college_id")
                              .select("departments.*, c.code AS  college_code")
    render json: @departments
  end

  # GET /departments/1
  def show
    render json: @department
  end

  def get_department_by_college_id
    _department =  Department.joins("INNER JOIN colleges as c ON c.id = departments.college_id")
                              .select("departments.*, c.code As college_code")
                              .where(college_id: params[:college_id])
    render json: _department
  end
  
  # def get_curriculum_by_college_id
  #   _curriculum =  Curriculum.joins("LEFT JOIN colleges as c ON c.id = curriculums.college_id")
  #                             .select("curriculums.*, c.code As college_code")
  #                             .where(college_id: params[:college_id])
  #   render json: _curriculum
  # end

  # POST /departments
  def create
    @department = Department.new(department_params)
    if @department.save
      render json: @department, status: :created
    else
      render json: @department.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /departments/1
  def update
    if @department.update(department_params)
      render json: @department
    else
      render json: @department.errors, status: :unprocessable_entity
    end
  end

  # DELETE /departments/1
  def destroy
    @department.destroy
  end

  def token_claims
    {
      aud: allowed_aud,
      verify_aud: true
    }
  end

  private
    def allowed_aud
      # action_name == 'update' ? EDIT_AND_CREATE_ROLES : VIEW_ROLES
      if action_name == 'update'|| action_name == 'create' || action_name == 'destroy' 
        EDIT_AND_CREATE_ROLES
      else
        VIEW_ROLES
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_department
      @department = Department.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def department_params
      params.require(:department).permit(:code, :description, :college_id)
    end
end
