class Api::V1::CollegesController < ApplicationController
  before_action :authorize_access_request!
  before_action :set_college, only: [:show, :update, :destroy]
  VIEW_ROLES = %w[adviser dean system_admin].freeze
  EDIT_AND_CREATE_ROLES = %w[system_admin].freeze

  # GET /colleges
  def index
    @colleges = College.all
    render json: @colleges
  end

  # GET /colleges/1
  def show
    render json: @college
  end

  # POST /colleges
  def create
    @college = College.new(college_params)
    if @college.save
      render json: @college, status: :created
    else
      render json: @college.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /colleges/1
  def update
    if @college.update(college_params)
      render json: @college
    else
      render json: @college.errors, status: :unprocessable_entity
    end
  end

  # DELETE /colleges/1
  def destroy
    @college.destroy
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
      if action_name == 'update'|| action_name == 'create' || action_name == 'destroy' 
        EDIT_AND_CREATE_ROLES
      else
        VIEW_ROLES
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_college
      @college = College.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def college_params
      params.require(:college).permit(:code, :description)
    end
end
