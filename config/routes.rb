Rails.application.routes.draw do

  post 'refresh', controller: :refresh, action: :create
  post 'student_signin', controller: :signin, action: :student_login
  post 'staff_signin', controller: :signin, action: :staff_login
  post 'admin_signin', controller: :signin, action: :admin_login
  delete 'signin', controller: :signin, action: :destroy
  get 'me', controller: :users, action: :me

  # resources :password_resets, only: [:create] do
  #   collection do
  #     get ':token', action: :edit, as: :edit
  #     patch ':token', action: :update
  #   end
  # end
  
  namespace :api do
    namespace :v1 do
      resources :users
      resources :advices
      resources :subjects
      resources :curriculums
      resources :colleges
      resources :prerequisites
      resources :majors
      resources :admins
      resources :staffs
      resources :students
      resources :enrollments
      resources :recommendations
      resources :departments
      resources :academic_years
      get 'adviser_students', controller: :students, action: :adviser_students
      get 'get_stud_advising', controller: :advices, action: :get_stud_advising
      get 'search_student', controller: :students, action: :search_student
      get 'get_curriculum_by_college_id', controller: :curriculums, action: :get_curriculum_by_college_id
      get 'get_department_by_college_id', controller: :departments, action: :get_department_by_college_id
      get 'find_prerequisites_by_subject_id', controller: :prerequisites, action: :find_prerequisites_by_subject_id
      get 'get_student_recommended_subjects', controller: :recommendations, action: :get_student_recommended_subjects
      get 'recommendation_year_sem', controller: :recommendations, action: :recommendation_year_sem
      get 'get_student_enrolled_subjects', controller: :enrollments, action: :get_student_enrolled_subjects
      get 'check_if_prereq_exist', controller: :recommendations, action: :check_if_prereq_exist
      get 'count', controller: :counts, action: :count
      get 'roles', controller: :users, action: :show_roles
    end
  end
end

