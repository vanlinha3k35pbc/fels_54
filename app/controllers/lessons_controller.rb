class LessonsController < ApplicationController
  before_action :logged_in_user

  def show
    @category = Category.find params[:category_id]
    @lesson = Lesson.find params[:id]
    @right_answers_amount = Answer.right_answers_amount @lesson
  end

  def new
    @category = Category.find params[:category_id]
    @lesson = Lesson.new
    @words = @category.words.random_words current_user
    @words.each {|word| @lesson.results.build word_id: word.id}
    @timestamp = Time.now.to_i
  end

  def create
    @category = Category.find params[:category_id]
    @lesson = @category.lessons.build lesson_params
    @lesson.user = current_user
    
    if session[:last_lesson_created_at].to_i > params[:timestamp].to_i
      flash[:danger] = "You can not edit submited lesson and have to learn new lesson"
      redirect_to new_category_lesson_path @category
    else
      if @lesson.save
        session[:last_lesson_created_at] = Time.now.to_i
        flash[:success] = "Lesson created!"
        redirect_to [@category, @lesson]
      else
        flash[:danger] = "Something went wrong! Can not create lesson"
        redirect_to :back
      end
    end
  end

  private
  def lesson_params
    params.require(:lesson).permit results_attributes: [:word_id, :answer_id]
  end
end
