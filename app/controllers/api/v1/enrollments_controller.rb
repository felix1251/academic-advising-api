class Api::V1::EnrollmentsController < ApplicationController
  before_action :authorize_access_request!
  before_action :set_enrollment, only: [:show, :update, :destroy]

  # GET /enrollments
  def index
    @enrollments = Enrollment.all

    render json: @enrollments
  end

  # GET /enrollments/1
  def show
    render json: @enrollment
  end

  def get_student_enrolled_subjects
    @enrollments = Enrollment.joins("LEFT JOIN subjects as s ON s.id = enrollments.enrolled_id")
                              .select("enrollments.*, s.id AS subject_id, s.code AS subject_code, s.description AS subject_description, s.units")
                              .where("student_id = #{params["student_id"]}")
    render json: @enrollments
  end

  # POST /enrollments
  def create
    @enrollment = Enrollment.new(enrollment_params)
    if @enrollment.save
      render json: @enrollment, status: :created
    else
      render json: @enrollment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /enrollments/1
  def update
    if @enrollment.update(enrollment_params)
      render json: @enrollment
    else
      render json: @enrollment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /enrollments/1
  def destroy
    @enrollment.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_enrollment
      @enrollment = Enrollment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def enrollment_params
      params.require(:enrollment).permit(:enrolled_id, :student_id, :sem, :datetime_enrolled, :academic_year_id)
    end
end