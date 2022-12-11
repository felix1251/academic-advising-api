class Api::V1::RecommendationsController < ApplicationController
  before_action :authorize_access_request!
  before_action :set_recommendation, only: [:show, :update, :destroy]

  # GET /recommendations
  def index
    @recommendations  = Recommendation.joins("LEFT JOIN subjects as s ON s.id = recommendations.subject_id
                                      LEFT JOIN curriculums as c ON c.id = recommendations.curriculum_id")
                                      .select('recommendations.*, s.code AS subject_code, c.code AS curriculum_code, s.description AS subject_description, c.description AS curriculum_description, s.units')
                                      .order("curriculum_code, year")                

    render json: @recommendations
  end

  def get_student_recommended_subjects
    @enrollments = Recommendation.joins("LEFT JOIN enrollments AS e ON e.student_id = #{params["student_id"]} AND e.enrolled_id = recommendations.subject_id
                                  LEFT JOIN subjects as s ON s.id = recommendations.subject_id
                                  LEFT JOIN curriculums as c ON c.id = recommendations.curriculum_id")
                                  .select("recommendations.*, s.code AS subject_code, c.code AS curriculum_code, s.description AS subject_description,
                                  c.description AS curriculum_description, s.units, CASE WHEN e.student_id IS NULL THEN 'NO' ELSE 'YES' END AS is_enrolled")
                                  .where("curriculum_id = #{params["student_curriculum_id"]}")
                                  .where("is_enrolled = 'NO'")
    render json: @enrollments
  end

  def get_student_remaining_units
    get_user = Student.find_by_id(payload["user_id"])
    units_sum_total = Recommendation.joins("LEFT JOIN enrollments AS e ON e.student_id = #{get_user.id} AND 
                                      e.enrolled_id = recommendations.subject_id
                                      LEFT JOIN subjects as s ON s.id = recommendations.subject_id
                                      LEFT JOIN enrollments as en ON en.enrolled_id = recommendations.subject_id AND en.student_id = #{get_user.id}
                                      LEFT JOIN curriculums as c ON c.id = recommendations.curriculum_id")
                                      .select("en.grade, s.units, c.id AS curriculum_id")
                                      .where("curriculum_id = #{get_user.curriculum_id}")
                                      .sum(:units)

    units_sum_remaining = Recommendation.joins("LEFT JOIN enrollments AS e ON e.student_id = #{get_user.id} AND 
                                        e.enrolled_id = recommendations.subject_id
                                        LEFT JOIN subjects as s ON s.id = recommendations.subject_id
                                        LEFT JOIN enrollments as en ON en.enrolled_id = recommendations.subject_id AND en.student_id = #{get_user.id}
                                        LEFT JOIN curriculums as c ON c.id = recommendations.curriculum_id")
                                        .select("en.grade, s.units, c.id AS curriculum_id")
                                        .where("curriculum_id = #{get_user.curriculum_id} AND en.grade NOT IN (#{["5", "INC", "P", "DRP", "IP"].join(",")})")
                                        .sum(:units)

    render json: {total_units: units_sum_total, remaining_units: units_sum_remaining}
  end

  def recommendation_year_sem
    get_user = Student.find_by_id(params["student_id"])
    recom =  Recommendation.joins("LEFT JOIN enrollments AS e ON e.student_id = #{params["student_id"]} AND 
                                  e.enrolled_id = recommendations.subject_id
                                  LEFT JOIN subjects as s ON s.id = recommendations.subject_id
                                  LEFT JOIN enrollments as en ON en.enrolled_id = recommendations.subject_id AND en.student_id = #{params["student_id"]}
                                  LEFT JOIN curriculums as c ON c.id = recommendations.curriculum_id")
                                  .select("recommendations.*, s.code AS subject_code, c.code AS curriculum_code, s.description AS subject_description, c.description AS curriculum_description,
                                  en.grade, s.units, c.id AS curriculum_id, CASE WHEN e.student_id IS NULL THEN 'NO' ELSE 'YES' END AS is_enrolled")
                                  .where("curriculum_id = #{get_user.curriculum_id}")

    years = [1, 2, 3, 4]
    sems = [1,2,3]
    recom_year_list = {}
    recom_sem_list = {}

    years.each do |year|
      object = []
      sems.each do |sem|
        sem_value = recom.where("year = #{year}").where("semester = #{sem}") rescue 0
        set =  {sem: sem, data: sem_value }
        object.push(set)
      end
      recom_year_list[year] = object
    end   

    render json: { rows: recom_year_list, selected_rows: recom.where("en.grade != null").collect(&:subject_id) }
  end

  def check_if_prereq_exist
    to_check = params[:subject_id]
    selected_id_rows = params[:selected_rows]
    check_condition = Subject.find_by_id(to_check)
    prerequisite_check = Prerequisite.where("subject_id = #{to_check}")

    if selected_id_rows.length() == 0
      selected_id_rows = []
    end

    if check_condition.prerequisite_condition == "AND"
      all_array = prerequisite_check.pluck(:subject_id)
      grouping = prerequisite_check.pluck(:group_id)
      set = false
      grouping.each do |g|
        check_array = prerequisite_check.where("group_id = #{g}").pluck(:subject_id)
        set = contains_all(check_array, selected_id_rows)
      end
      if set == false
        render json: {check: "prerequisite not check"}, status: :unprocessable_entity
      end
    elsif check_condition.prerequisite_condition == "OR"
      set = false
      some_array = prerequisite_check.pluck(:subejct_id)
      grouping = prerequisite_check.pluck(&:group_id)
      grouping.each do |g|
        check_array = prerequisite_check.where("group_id = #{g}").pluck(:subject_id)
        set = contains_any(check_array, selected_id_rows)
      end
      if set == false
        render json: {check: "prerequisite not check"}, status: :unprocessable_entity
      end
    else
      check_array = prerequisite_check.pluck(:subject_id)
      set = contains_any(check_array, selected_id_rows)
    end
  end

  # GET /recommendations/1
  def show
    render json: @recommendation
  end

  # POST /recommendations
  def create
    @recommendation = Recommendation.new(recommendation_params)

    if @recommendation.save
      render json: @recommendation, status: :created
    else
      render json: @recommendation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /recommendations/1
  def update
    if @recommendation.update(recommendation_params)
      render json: @recommendation
    else
      render json: @recommendation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /recommendations/1
  def destroy
    @recommendation.destroy
  end

  private

    def contains_all(ids, selected_ids)
      ids.each do |id|
        return false unless selected_ids.include?(id)
      end
      return true
    end

    def contains_any(ids, selected_ids)
      ids.each do |id|
        return true if selected_ids.include?(id)
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_recommendation
      @recommendation = Recommendation.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def recommendation_params
      params.require(:recommendation).permit(:semester, :subject_id, :curriculum_id, :year)
    end
end
