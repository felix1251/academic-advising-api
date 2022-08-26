class Api::V1::SubjectsController < ApplicationController
  before_action :authorize_access_request!
  before_action :set_subject, only: [:show, :update, :destroy]
  VIEW_ROLES = %w[F D A].freeze
  EDIT_AND_CREATE_ROLES = %w[A].freeze

  # GET /subjects
  def index
    # @subjects = Subject.all
    @subjects  = Subject.joins("LEFT JOIN colleges as c ON c.id = subjects.college_id
                                LEFT JOIN departments as d ON d.id = subjects.department_id")
                                .select('subjects.*, c.code AS college_code, d.code AS department_code,
                                d.description AS department_description ')
    render json: @subjects
  end

  # GET /subjects/1
  def show
    render json: @subject
  end

  # POST /subjects
  def create
    @subject = Subject.new(subject_params)

    if @subject.save
      render json: @subject, status: :created
    else
      render json: @subject.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /subjects/1
  def update
    if @subject.update(subject_params)
      render json: @subject
    else
      render json: @subject.errors, status: :unprocessable_entity
    end
  end

  # DELETE /subjects/1
  def destroy
    if @subject.destroy
      render json: { status: "successfully deleted" }, status: :ok
    else
      render json: @subject.errors, status: :unprocessable_entity
    end
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
      if action_name == 'update' || action_name == 'create' || action_name == 'destroy' 
        EDIT_AND_CREATE_ROLES
      else
        VIEW_ROLES
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_subject
      @subject = Subject.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def subject_params
      params.require(:subject).permit(:code, :description, :units, :college_id, :department_id, :prerequisite_condition)
    end
end
