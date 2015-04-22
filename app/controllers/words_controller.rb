class WordsController < ApplicationController
  before_action :logged_in_user

  def index
    @categories = Category.all
    @category = Category.find_by(id: params[:category_id]) || Category.first
    
    if %w[learned_words not_learned_words].include? params[:filter]
      @filter = params[:filter]
      filter_words = @category.words.send @filter, current_user
    else
      @filter = "all"
      filter_words = @category.words
    end

    @words = filter_words.paginate page: params[:page]
  end
end
