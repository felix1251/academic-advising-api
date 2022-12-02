class Api::V1::AdvicesController < ApplicationController
  before_action :authorize_access_request!
  before_action :set_advice, only: [:show, :update, :destroy]

  # GET /advices
  def index
    @advices = Advice.all
    render json: @advices
  end

  # GET /advices/1
  def show
    render json: @advice
  end

  def get_stud_advising
    studs_count = Student.where(adviser_id: payload['user_id']).count
    render json: { studs_count: studs_count }
  end

  # POST /advices
  def create
    @advice = Advice.new(advice_params)

    if @advice.save
      render json: @advice, status: :created, location: @advice
    else
      render json: @advice.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /advices/1
  def update
    if @advice.update(advice_params)
      render json: @advice
    else
      render json: @advice.errors, status: :unprocessable_entity
    end
  end

  # DELETE /advices/1
  def destroy
    @advice.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_advice
      @advice = Advice.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def advice_params
      params.require(:advice).permit(:staff, :student, :message, :subject_ids => [])
    end
end
