class SigninController < ApplicationController
  before_action :authorize_access_request!, only: [:destroy]

  # def create
  #   user = User.find_by!(username: params[:username])
  #   if user.authenticate(params[:password])
  #     payload  = { user_id: user.id, aud: [user.role] }
  #     session = JWTSessions::Session.new(payload: payload,
  #                                       refresh_by_access_allowed: true,
  #                                       namespace: "user_#{user.id}")
  #     tokens = session.login

  #     response.set_cookie(JWTSessions.access_cookie,
  #                         value: tokens[:access],
  #                         httponly: true,
  #                         secure: Rails.env.production?)
  #     render json: { csrf: tokens[:csrf] }
  #   else
  #     not_authorized
  #   end
  # end

  def student_login
    student = Student.find_by!(username: params[:username])
    if student.authenticate(params[:password])
      payload  = { user_id: student.id, aud: ["S"] }
      session = JWTSessions::Session.new(payload: payload,
                                        refresh_by_access_allowed: true,
                                        namespace: "user_#{student.id}")
      tokens = session.login
      response.set_cookie(JWTSessions.access_cookie,
                          value: tokens[:access],
                          httponly: true,
                          secure: Rails.env.production?)
      render json: { csrf: tokens[:csrf], access: payload["aud"]}
    else
      not_authorized
    end
  end

  def staff_login
    staff = Staff.find_by!(username: params[:username])
    if staff.authenticate(params[:password])
      if staff.is_dean
        payload  = { user_id: staff.id, aud: ["F", "D"] }
      else
        payload  = { user_id: staff.id, aud: ["F"] }
      end
      session = JWTSessions::Session.new(payload: payload,
                                        refresh_by_access_allowed: true,
                                        namespace: "user_#{staff.id}")
      tokens = session.login

      response.set_cookie(JWTSessions.access_cookie,
                          value: tokens[:access],
                          httponly: true,
                          secure: Rails.env.production?)
      render json: { csrf: tokens[:csrf], access: payload["aud"]}
    else
      not_authorized
    end
  end

  def admin_login
    admin = Admin.find_by!(username: params[:username])
    if admin.authenticate(params[:password])
      payload  = { user_id: admin.id, aud: ["A"] }
      session = JWTSessions::Session.new(payload: payload,
                                        refresh_by_access_allowed: true,
                                        namespace: "user_#{admin.id}")
      tokens = session.login

      response.set_cookie(JWTSessions.access_cookie,
                          value: tokens[:access],
                          httponly: true,
                          secure: Rails.env.production?)
      render json: { csrf: tokens[:csrf], access: payload["aud"] }
    else
      not_authorized
    end
  end

  def destroy
    session = JWTSessions::Session.new(payload: payload, namespace: "user_#{payload['user_id']}")
    session.flush_by_access_payload
    render json: :ok
  end

  private

  def not_found
    render json: { error: 'Cannont find such username and password combination' }, status: :not_found
  end
end
