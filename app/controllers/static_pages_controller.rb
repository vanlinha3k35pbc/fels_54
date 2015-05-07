class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @feed_items = Activity.feed_activities(current_user)
        .paginate page: params[:page], per_page: 15
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
