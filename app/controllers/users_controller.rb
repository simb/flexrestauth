class UsersController < ApplicationController
  before_filter :login_required, :only => [:index ]
  
  def index
    @users = User.find(:all)
    respond_to do |format|
      format.html
      format.xml { render :xml => @users.to_xml(:dasherize => false)}
    end
  end

  # render new.rhtml
  def new
  end

  def create
    cookies.delete :auth_token
    # protects against session fixation attacks, wreaks havoc with 
    # request forgery protection.
    # uncomment at your own risk
    # reset_session
    @user = User.new(params[:user])
    @user.save
    if @user.errors.empty?
      self.current_user = @user
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!"
    else
      render :action => 'new'
    end
  end

end
