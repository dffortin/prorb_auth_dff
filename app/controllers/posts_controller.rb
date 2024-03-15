class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    @posts = Post.all
    @user_id = session[:user_id]
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post = Post.includes(:user).find(params[:id])
    @user_id = session[:user_id]
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    @user_id = session[:user_id]
    begin
      @post = Post.post_owner(@user_id).find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      flash[:alert] = "You are not authorized to edit/update this post."
      redirect_to posts_path
    end
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    @post.user_id = session[:user_id]

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

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    @user_id = session[:user_id]
      begin
        if @post.id = Post.post_owner(@user_id).find(@post.id).id
        then @post.update(post_params)
          respond_to do |format|
            format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
            format.json { render :show, status: :ok, location: @post }
      rescue ActiveRecord::RecordNotFound => e
        flash[:alert] = "You are not authorized to edit/update this post."
        redirect_to posts_path
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @user_id = session[:user_id]
    begin
      if @post.id = Post.post_owner(@user_id).find(params[:id]).id
      then @post.destroy
      respond_to do |format|
        format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
        format.json { head :no_content }
    rescue ActiveRecord::RecordNotFound => e
      flash[:alert] = "You are not authorized to edit/update this post."
      redirect_to posts_path
    else 
      format.html { render :edit, status: :unprocessable_entity }
      format.json { render json: @post.errors, status: :unprocessable_entity }
    end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body, :user_id)
    end

end
