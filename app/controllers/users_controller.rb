class UsersController < ApplicationController
  require 'open-uri'
  before_action :authenticate_user!, only: [:index, :edit, :destroy, :update]

  def index
    @users = User.all
  end
  
  def show
    redirect_to "/" if params[:id] ==  "null"
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = current_user
  end

  def create
    @user = User.new(create_user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to login_path, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user = current_user
    respond_to do |format|
      if @user.update(update_user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    current_user.destroy
    reset_session
    redirect_to root_path, notice: "Your account has been deleted."
  end

  def share_image_as_post
    user = User.find_by(id: params[:user_id])
    url = url_for(user.uploads.find_by(id: params[:upload_id]))
    
    post = Post.new
    post.title = "Post by #{user.username}"
    post.user_id = params[:user_id]

    image_url = open(url)
    post.upload.attach(io: image_url, filename: 'name.png', content_type: 'image/png')
    
    respond_to do |format|
      if post.save
        format.html { redirect_to post_url(post), notice: "Upload shared successfully." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def create_user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :username, uploads: [])
    end
  
    def update_user_params
      params.require(:user).permit(:current_password, :password, :password_confirmation, :first_name, :last_name, :username, uploads: [])
    end
end
