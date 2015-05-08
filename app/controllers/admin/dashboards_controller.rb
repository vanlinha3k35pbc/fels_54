class Admin::DashboardsController < ApplicationController
  before_action :logged_in_user, :admin_user
  
  def index
    
  end
end
