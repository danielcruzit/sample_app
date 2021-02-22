class UsersController < ApplicationController

  before_action :set_user, only: [:show, :destroy, :edit, :update]

  def show

  end
    
  def new
    @user = User.new
  end

   def create
      @user = User.new(user_params)
      if @user.save
        log_in @user
        flash[:success] = "Welcome to the Sample App!"
        redirect_to @user
      else
        render 'new' 
     end
   end
  

  def destroy
    if @user.present? 
      @user.destroy
    end
  end
 
  def edit
  end

  def update
     if @user.update(user_edit_params)
      flash[:success] = "User edited ! sucesso!"
      redirect_to @user
     else
      flash[:danger] = "Error in changes! insucesso"
      render 'edit'
     end
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

end