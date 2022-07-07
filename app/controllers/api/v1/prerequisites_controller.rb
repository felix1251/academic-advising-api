class Api::V1::PrerequisitesController < ApplicationController
  before_action :authorize_access_request!
  before_action :set_prerequisite, only: [:show, :update, :destroy]

  # GET /prerequisites
  def index
    @prerequisites = Prerequisite.joins("LEFT JOIN subjects as s1 ON s1.id = prerequisites.subject_id
                                        LEFT JOIN subjects as s2 ON s2.id = prerequisites.subject_prerequisite_id")
                                        .select('prerequisites.*, s1.code AS subject_code, s2.code AS prerequisite_code,
                                        s1.description AS subject_description,
                                        s2.description AS prerequisite_description')

    render json: @prerequisites
  end

  def find_prerequisites_by_subject_id
    @prerequisites = Prerequisite.joins("LEFT JOIN subjects as s1 ON s1.id = prerequisites.subject_id
                                        LEFT JOIN subjects as s2 ON s2.id = prerequisites.subject_prerequisite_id")
                                        .select('prerequisites.*, s1.code AS subject_code, s2.code AS prerequisite_code,
                                        s1.description AS subject_description,
                                        s2.description AS prerequisite_description')
                                        .where(subject_id: params[:subject_id])

    render json: @prerequisites
  end

  # GET /prerequisites/1
  def show
    render json: @prerequisite
  end

  # POST /prerequisites
  def create
    @prerequisite = Prerequisite.new(prerequisite_params)

    if @prerequisite.save
      render json: @prerequisite, status: :created
    else
      render json: @prerequisite.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /prerequisites/1
  def update
    if @prerequisite.update(prerequisite_params)
      render json: @prerequisite
    else
      render json: @prerequisite.errors, status: :unprocessable_entity
    end
  end

  # DELETE /prerequisites/1
  def destroy
    @prerequisite.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prerequisite
      @prerequisite = Prerequisite.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def prerequisite_params
      params.require(:prerequisite).permit(:subject_id, :subject_prerequisite_id, :group_id)
    end
end
