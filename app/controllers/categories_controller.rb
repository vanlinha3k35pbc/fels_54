class CategoriesController < ApplicationController
  def index
    @categories = Category.paginate page: params[:page], per_page: 5
  end
end
