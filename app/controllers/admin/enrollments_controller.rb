class Admin::EnrollmentsController < ApplicationController
  before_action :authenticate_user

  # GET - /admin/enrollments
  def index
    @enrollments = Enrollment
                    .joins(:course, :user)
                    .where(organization_id: @current_organization_id)
                    .order(created_at: :desc)
                    .page(params[:page] || 1)
  end

  # POST - /admin/enrollments
  def create
    course = Course.find_by(id: enrollment_param[:course_id], organization_id: @current_organization_id)
    if course.nil?
      return render json: { message: 'No course found with the given course id' }, status: :not_found
    end

    user = User.find_by(id: enrollment_param[:user_id], organization_id: @current_organization_id)
    if user.nil?
      return render json: { message: 'No user found with the given user id' }, status: :not_found
    end

    existing_enrollment = Enrollment.find_by(course_id: enrollment_param[:course_id], user_id: enrollment_param[:user_id], organization_id: @current_organization_id)
    if !existing_enrollment.nil?
      return render json: { message: 'Enrollment already exists with the given user and course' }, status: :conflict
    end    

    @enrollment = Enrollment.new(enrollment_param)
    @enrollment.organization_id = @current_organization_id
    @enrollment.enrolled_on = Time.now
    @enrollment.save!
    render status: :created
  end

  private
    def enrollment_param
      params.require(:enrollment).permit(:course_id, :user_id, :role, :valid_till)
    end
end