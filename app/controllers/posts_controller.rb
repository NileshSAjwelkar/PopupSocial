class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy ]

  def index
    @posts = Post.all
  end

  def show
    @user_mentions = find_mentions(@post) rescue []
  end

  def new
    @post = Post.new
    @users = User.all
  end

  def edit
    @users = User.all
  end

  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def search
    user = User.find_by(username: params["search_string"])  
    @posts = user.posts
  end

  private
    def find_mentions(post)
      m = CustomMentionProcessor.new
      m.process_mentions(post)
    end
  
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :content, :user_id, :upload, :tag_list)
    end
end
