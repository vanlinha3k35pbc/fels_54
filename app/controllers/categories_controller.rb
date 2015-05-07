class CategoriesController < ApplicationController
  before_action :logged_in_user

  def index
    @categories = Category.created_time_sort.paginate page: params[:page],
      per_page: 5
  end
end
