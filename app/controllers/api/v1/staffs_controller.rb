class  Api::V1::StaffsController < ApplicationController
  before_action :set_staff, only: [:show, :update, :destroy]

  # GET /staffs
  def index
    @staffs = Staff.joins("LEFT JOIN departments AS dp ON dp.id = staffs.department_id LEFT JOIN colleges AS co ON co.id = staffs.college_id")
                          .select("staffs.*, co.code AS college_code, dp.code AS department_code")

    if params[:college_id].present?
      @staffs = @staffs.where(college_id: params[:college_id])
    end
  
    render json: @staffs
  end

  # GET /staffs/1
  def show
    render json: @staff
  end

  # POST /staffs
  def create
    @staff = Staff.new(staff_params)
    if @staff.save
      render json: @staff, status: :created
    else
      render json: @staff.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /staffs/1
  def update
    if @staff.update(staff_params)
      render json: @staff
    else
      render json: @staff.errors, status: :unprocessable_entity
    end
  end

  # DELETE /staffs/1
  def destroy
    @staff.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_staff
      @staff = Staff.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def staff_params
      params.require(:staff).permit(:username, :password, :password_confirmation, :first_name, :middle_name, :last_name, :suffix, :gender, :college_id, :department_id)
    end
end
