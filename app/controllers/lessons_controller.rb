class LessonsController < ApplicationController
  before_action :logged_in_user

  def show
    @category = Category.find params[:category_id]
    @lesson = Lesson.find params[:id]
  end

  def new
    @category = Category.find params[:category_id]
    @lesson = Lesson.new
    @words = @category.words.random_words current_user

    @words.each do |word|
      @lesson.results.build word_id: word.id
    end
  end

  def create
    @category = Category.find params[:category_id]
    @lesson = @category.lessons.build lesson_params
    @lesson.user = current_user
    if @lesson.save
      flash[:success] = "Lesson created!"
      redirect_to [@category, @lesson]
    else
      flash[:danger] = "Something went wrong"
      redirect_to :back
    end
  end

  private
  def lesson_params
    params.require(:lesson).permit results_attributes: [:word_id, :answer_id]
  end
end
