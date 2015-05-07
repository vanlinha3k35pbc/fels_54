class CategoriesController < ApplicationController
  before_action :logged_in_user

  def index
    @categories = Category.sort.paginate page: params[:page], per_page: 5
  end
end
