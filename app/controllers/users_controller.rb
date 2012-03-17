class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update, :destroy, :show]
  before_filter :correct_user, :only => [:edit, :update, :show]
  before_filter :admin_user,   :only => [:index,:destroy]
  
  
  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
	@item1_name = @user.item1_name
	@item2_name = @user.item2_name
	@item1_type = @user.item1_type
	@item2_type = @user.item2_type
	@sitelink_id = @user.sitelink_id
	@sitelink = @user.sitelink
	@url = @sitelink.url
	agent = Mechanize.new
	page = agent.get(@url)
	@response = page.content
	doc = Hpricot(@response)
	

	@eggs = doc.search("//table[@class='mytable']").search("//td[@class='eggs']").innerHTML
	@item1 = Integer(doc.search("//table[@class='mytable']").search("//td[@class='item1']").innerHTML)
	@item2 = Integer(doc.search("//table[@class='mytable']").search("//td[@class='item2']").innerHTML)
	@item1_rem = Integer(doc.search("//table[@class='mytable']").search("//td[@class='item1_rem']").innerHTML)
	@item2_rem = Integer(doc.search("//table[@class='mytable']").search("//td[@class='item2_rem']").innerHTML)
	@item1 = @item1 + @item1_rem
	@item2 = @item2 + @item2_rem
	
	
	if @item1_type=="L" or @item1_type=="kg"
		@item1 = @item1/1000.00
	end
	if @item2_type=="L" or @item2_type=="kg"
		@item2 = @item1/1000.00
	end
  end

  def new
    @user = User.new
    @title = "Sign up"
	@item1_name = @user.item1_name
	@item2_name = @user.item2_name
	@item1_type = @user.item1_type
	@item2_type = @user.item2_type
	@sitelink_id = @user.sitelink_id
  end
  
  
	def create
		@user = User.new(params[:user])
		if @user.save
		  sign_in @user
		  flash[:success] = "Welcome to the Sample App!"
		  redirect_to @user
		else
		  @title = "Sign up"
		  render 'new'
		end
	end


  def edit
    @user = User.find(params[:id])
    @title = "Edit user"
	@item1_type = @user.item1_type
	@item2_type = @user.item2_type
	
  end

 def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
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