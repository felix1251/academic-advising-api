class  Api::V1::StudentsController < ApplicationController
  before_action :set_student, only: [:show, :update, :destroy]

  # GET /students
  def index
    @students = Student.all
    render json: @students
  end

  # GET /students/1
  def show
    render json: @student
  end

  def search_student
    if params[:id_number].present?
      student = Student.joins("LEFT JOIN colleges as c ON c.id = students.college_id
                        LEFT JOIN curriculums as cu ON cu.id = students.curriculum_id")
                        .select('students.id, students.id_number, students.first_name,
                        students.middle_name, students.last_name, students.suffix, students.college_id, 
                        students.curriculum_id, c.code AS college_code, cu.code AS curriculum_code,
                        cu.description AS curriculum_description, c.description AS college_description')
                        .find_by!(id_number: params[:id_number])
                        
      render json: student
    else
      render json: {result: "params empty"}, status: :unprocessable_entity
    end
  end

  # POST /students
  def create
    @student = Student.new(student_params)

    if @student.save
      render json: @student, status: :created
    else
      render json: @student.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /students/1
  def update
    if @student.update(student_params)
      render json: @student
    else
      render json: @student.errors, status: :unprocessable_entity
    end
  end

  # DELETE /students/1
  def destroy
    @student.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def student_params
      params.fetch(:student, {})
    end
end
