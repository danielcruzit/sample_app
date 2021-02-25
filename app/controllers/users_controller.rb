class UsersController < ApplicationController

  before_action :set_user, only: [:show, :destroy, :edit, :update,:followers,:following]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,:followers,:following]
  before_action :correct_user, only: [:edit, :update]
  before_action :logged_admin, only: :destroy
  

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
      @city= @user.city_address
      @microposts = @user.microposts.paginate(page: params[:page])
      @followers_count = @user.followers.count
      @following_count = @user.following.count
  end
    
  def new
    @user = User.new
  end

   def create
      @user = User.new(user_params)
      if @user.save
        log_in @user
        flash[:success] = "Welcome to the Sample App!"
        redirect_back_or @user
      else
        render 'new' 
     end
   end
  

   def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
   end

  #edit is like new in this context, gets info but doesn't change db
  def edit
     
  end

  def update
     if @user.update(user_params)
      flash[:success] = "User edited ! sucesso!"
      redirect_to @user
     else
      flash[:danger] = "Error in changes! insucesso"
      render 'edit'
     end
  end
   
  #before action sets users
  def following
      @title = "Following"
      @users = @user.following.paginate(page: params[:page])
      @followers_count = current_user.followers.count
      @following_count = current_user.following.count
      render 'show_follow'
  end


  #before action sets user
  def followers
      @title = "Followers"
      @users = @user.followers.paginate(page: params[:page])
      @followers_count = current_user.followers.count
      @following_count = current_user.following.count
      render 'show_follow'
  end
  


private

   def user_params
    params.require(:user).permit(:name, :email, :phone_number, :password, :password_confirmation) 
   end

   def user_edit_params
    params.require(:user).permit(:name, :phone_number, :password, :password_confirmation) 
   end

   def set_user
    @user = User.find(params[:id])
   end


  def logged_admin
    redirect_to(root_url) unless current_user.admin?  
  end

  # Confirms the correct user. 
  def correct_user
    @user = User.find(params[:id])
    unless current_user?(@user) 
      flash[:danger] = "You can only change your settings." 
      redirect_to root_url
    end
  end

end