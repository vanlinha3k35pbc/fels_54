class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @learned_words_amount = Word.learned_words(current_user).count
      @feed_items = current_user.feed.paginate page: params[:page], per_page: 15
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
