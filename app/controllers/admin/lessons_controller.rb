class Admin::LessonsController < ApplicationController
  before_action :logged_in_user, :admin_user
  
  def index
    @lessons = Lesson.paginate page: params[:page], per_page: 15
  end

  def destroy
    Lesson.find(params[:id]).destroy
    flash[:success] = "Lesson deleted"
    redirect_to admin_lessons_path
  end
end
