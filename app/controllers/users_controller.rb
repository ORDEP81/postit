class UsersController < ApplicationController

def new
  @user = User.new
end

def create
  @user = User.new(params.require(:user).permit(:username, :password))
    if @user.save 
      flash[:notice] = 'User has been created'
      redirect_to root_path
    else
      render :new
    end
end

def edit
end

def update 
end



end