class Api::V1::CurriculumsController < ApplicationController  
  before_action :authorize_access_request!
  before_action :set_curriculum, only: [:show, :update, :destroy]

  VIEW_ROLES = %w[F A D].freeze
  EDIT_AND_CREATE_ROLES = %w[A].freeze

  # GET /curriculums
  def index
    @curriculums  = Curriculum.find_by_sql("SELECT cu.*, c.code As college_code, d.code AS department_code,
                                          d.description AS department_description
                                          FROM curriculums AS cu
                                          INNER JOIN colleges AS c ON c.id = cu.college_id 
                                          INNER JOIN departments AS d ON d.id = cu.department_id")
    render json: @curriculums
  end

  # GET /curriculums/1
  def show
    @curriculum = Curriculum.find_by_sql("SELECT cu.*, c.code As college_code 
                                          FROM curriculums AS cu
                                          INNER JOIN colleges AS c ON c.id = cu.college_id")
    render json: @curriculum
  end

  def get_student_curriculum_subjects
    _curriculum =  Curriculum.joins("LEFT JOIN colleges as c ON c.id = curriculums.college_id")
                              .select("curriculums.*, c.code As college_code")
                              .where(college_id: params[:college_id])
  end

  def get_curriculum_by_college_id
    _curriculum =  Curriculum.joins("LEFT JOIN colleges as c ON c.id = curriculums.college_id")
                              .select("curriculums.*, c.code As college_code")
                              .where(college_id: params[:college_id])
    render json: _curriculum
  end

  # POST /curriculums
  def create
    @curriculum = Curriculum.new(curriculum_params)
    if @curriculum.save
      render json: @curriculum, status: :created
    else
      render json: @curriculum.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /curriculums/1
  def update
    if @curriculum.update(curriculum_params)
      render json: @curriculum
    else
      render json: @curriculum.errors, status: :unprocessable_entity
    end
  end

  # DELETE /curriculums/1
  def destroy
    @curriculum.destroy
  end

  def token_claims
    {
      aud: allowed_aud,
      verify_aud: true
    }
  end

  private
    def allowed_aud
      if action_name == 'update' || action_name == 'create' || action_name == 'destroy' 
        EDIT_AND_CREATE_ROLES
      else
        VIEW_ROLES
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_curriculum
      @curriculum = Curriculum.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def curriculum_params
      params.require(:curriculum).permit(:code, :description,:major_code, :department, :college_id, :department_id)
    end
end
