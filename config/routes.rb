Rails.application.routes.draw do
  post 'refresh', controller: :refresh, action: :create
  post 'signin', controller: :signin, action: :create
  post 'student_signin', controller: :signin, action: :student_login
  post 'staff_signin', controller: :signin, action: :staff_login
  post 'admin_signin', controller: :signin, action: :admin_login
  # post 'signup', controller: :signup, action: :create
  delete 'signin', controller: :signin, action: :destroy
  get 'me', controller: :users, action: :me

  # resources :todos, only: [:index], controller: 'users/todos'
  resources :todos

  resources :password_resets, only: [:create] do
    collection do
      get ':token', action: :edit, as: :edit
      patch ':token', action: :update
    end
  end
  
  namespace :api do
    # resources :users, only: [:index, :show, :update, :create] do
    #   resources :todos, only: [:index], controller: 'users/todos'
    # end
    namespace :v1 do
      get 'count', controller: :counts, action: :count
      get 'roles', controller: :users, action: :show_roles
      resources :users
      resources :subjects
      resources :curriculums
      resources :colleges
      resources :prerequisites
      resources :majors
      resources :admins
      resources :staffs
      resources :students
      get 'search_student', controller: :students, action: :search_student
      get 'get_curriculum_by_college_id', controller: :curriculums, action: :get_curriculum_by_college_id
      get 'get_department_by_college_id', controller: :departments, action: :get_department_by_college_id
      get 'find_prerequisites_by_subject_id', controller: :prerequisites, action: 
      :find_prerequisites_by_subject_id
      get 'get_student_recommended_subjects', controller: :recommendations, action: 
      :get_student_recommended_subjects
      get 'recommendation_year_sem', controller: :recommendations, action: 
      :recommendation_year_sem
      get 'get_student_enrolled_subjects', controller: :enrollments, action: 
      :get_student_enrolled_subjects
      get 'check_if_prereq_exist', controller: :recommendations, action: 
      :check_if_prereq_exist
      resources :departments
      resources :enrollments
      resources :recommendations
      resources :todos, only: [:index]
    end
  end
end
