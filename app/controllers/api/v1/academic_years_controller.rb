class Api::V1::AcademicYearsController < ApplicationController
  before_action :set_academic_year, only: [:show, :update, :destroy]

  # GET /academic_years
  def index
    @academic_years = AcademicYear.all

    render json: @academic_years
  end

  # GET /academic_years/1
  def show
    render json: @academic_year
  end

  # POST /academic_years
  def create
    @academic_year = AcademicYear.new(academic_year_params)

    if @academic_year.save
      render json: @academic_year, status: :created, location: @academic_year
    else
      render json: @academic_year.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /academic_years/1
  def update
    if @academic_year.update(academic_year_params)
      render json: @academic_year
    else
      render json: @academic_year.errors, status: :unprocessable_entity
    end
  end

  # DELETE /academic_years/1
  def destroy
    @academic_year.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_academic_year
      @academic_year = AcademicYear.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def academic_year_params
      params.require(:academic_year).permit(:from, :to)
    end
end
