class SitelinksController < ApplicationController


  before_filter :admin_user,   :only => [:index,:show, :new]

  def new
    @title = "New Sitelink"
  end
  def show
    @sitelink = Sitelink.find(params[:id])
  end
  def index
    @title = "All users"
    @sitelinks = Sitelink.paginate(:page => params[:page])
  end
  
private

    def authenticate
      deny_access unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
	
	def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
	
end
