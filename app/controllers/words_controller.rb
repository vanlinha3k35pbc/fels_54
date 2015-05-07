class WordsController < ApplicationController
  before_action :logged_in_user

  def index
    @categories = Category.created_time_sort
    @category = Category.find_by(id: params[:category_id]) || Category.first
    
    if %w[learned_words not_learned_words].include? params[:filter]
      @filter = params[:filter]
      @words = @category.words.send(@filter, current_user)
        .paginate page: params[:page], per_page: 15
    else
      @filter = "all"
      @words = @category.words.paginate page: params[:page], per_page: 15
    end
  end
end
