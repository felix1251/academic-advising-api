class Api::V1::MajorsController < ApplicationController
  before_action :set_major, only: [:show, :update, :destroy]

  # GET /majors
  def index
    @majors = Major.joins("LEFT JOIN colleges as c ON c.id = majors.college_id
                      LEFT JOIN curriculums as cu ON cu.id = majors.curriculum_id")
                      .select('majors.*, c.code AS college_code, cu.code as curriculum_code')

    render json: @majors
  end

  # GET /majors/1
  def show
    render json: @major
  end

  # POST /majors
  def create
    @major = Major.new(major_params)

    if @major.save
      render json: @major, status: :created
    else
      render json: @major.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /majors/1
  def update
    if @major.update(major_params)
      render json: @major
    else
      render json: @major.errors, status: :unprocessable_entity
    end
  end

  # DELETE /majors/1
  def destroy
    @major.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_major
      @major = Major.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def major_params
      params.require(:major).permit(:description, :college_id, :curriculum_id)
    end
end
