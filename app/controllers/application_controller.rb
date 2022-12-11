class ApplicationController < ActionController::API
  include JWTSessions::RailsAuthorization
  rescue_from ActionController::ParameterMissing, with: :bad_request
  rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized
  rescue_from JWTSessions::Errors::ClaimsVerification, with: :forbidden
  rescue_from JWTSessions::Errors::Expired, with: :token_expired
  rescue_from ResetPasswordError, with: :not_authorized

  private

  def current_user
    if payload['aud'].include?("S")
      @current_user ||= Student.find(payload['user_id'])
    elsif payload['aud'].include?("F")
      @current_user ||= Staff.find(payload['user_id'])
    else
      @current_user ||= Admin.find(payload['user_id'])
    end
  end

  def grade_list
    list_a = ["INC", "P", "DRP", "IP", "3", "5"]
    list_b = ["1", "1.25", "1.5", "1.75"]
    list_c = ["2", "2.25", "2.5", "2.75"]

    return list_a + list_b + list_c
  end

  def bad_request
    render json: { error: 'Bad request' }, status: :bad_request
  end

  def forbidden
    render json: { error: 'Forbidden' }, status: :forbidden
  end

  def not_authorized
    render json: { error: 'Not authorized' }, status: :unauthorized
  end

  def not_found
    render json: { error: 'Not found' }, status: :not_found
  end

  def token_expired
    render json: { error: 'Token expired' }, status: :unauthorized
  end

  def unprocessable_entity(exception)
    render json: { error: exception.record.errors.full_messages.join(' ') }, status: :unprocessable_entity
  end
end
