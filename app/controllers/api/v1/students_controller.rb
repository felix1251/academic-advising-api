class  Api::V1::StudentsController < ApplicationController
  before_action :set_student, only: [:show, :update, :destroy]

  # GET /students
  def index
    @students = Student.joins("LEFT JOIN colleges AS co ON co.id = students.college_id 
                              LEFT JOIN curriculums AS cu ON cu.id = students.curriculum_id
                              LEFT JOIN staffs AS stf ON stf.id = students.adviser_id")
                        .select("students.*, co.code AS college_code, cu.code AS curriculum_code, concat(stf.last_name,', ',stf.first_name) AS adviser_name")

    render json: @students
  end

  def adviser_students
    stud = Student.where(adviser_id: params[:adviser_id])
    render json: stud
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
      params.require(:student).permit(:id_number, :username, :password, :password_confirmation, :first_name, :middle_name, :last_name, :suffix, :gender, :college_id, :curriculum_id, :adviser_id)
    end
end
