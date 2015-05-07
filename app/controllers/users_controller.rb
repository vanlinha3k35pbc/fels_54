class UsersController < ApplicationController  
  def index
    @users = User.paginate page: params[:page], per_page: 15
  end

  def new
    @user = User.new
  end

  def show 
    @user = User.find params[:id]
    @learned_words_amount = Word.learned_words(current_user).count
    @activities = @user.activities.sort
  end


  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      redirect_to @user
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
      :password_confirmation)
  end
end
