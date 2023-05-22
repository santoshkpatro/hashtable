class Admin::CoursesController < ApplicationController
  before_action :authenticate_user

  # GET - /admin/courses
  def index
    @courses = Course.where(organization_id: @current_organization_id)
  end

  # POST - /admin/courses
  def create
    @course = Course.new(course_params)
    @course.slug = course_params[:title].parameterize
    @course.organization_id = @current_organization_id
    @course.save!
  end

  private
    def course_params
      params.require(:course).permit(:title, :description, :price, :validity)
    end
end