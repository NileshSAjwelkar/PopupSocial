class SessionsController < ApplicationController
  before_action :redirect_if_authenticated, only: [:create, :new]

  def create
    @user = User.find_by(email: params[:user][:email].downcase)

    respond_to do |format|
      if @user

        if @user.authenticate(params[:user][:password])
          login @user
          format.html { redirect_to root_path, notice: "Logged In successfully" }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { redirect_to login_path, notice: "Invalid Username or Password" }
          format.json { render :new, status: :created, location: @user }
        end
      else
        format.html { redirect_to login_path, notice: "Invalid Username or Password" }
        format.json { render :new, status: :created, location: @user }
      end
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: "Signed out."
  end

  def new
  end
end
