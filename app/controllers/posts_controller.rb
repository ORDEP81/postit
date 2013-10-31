class PostsController < ApplicationController
  
  before_action :set_post, only:[:edit, :show, :update, :vote]
  before_action :require_user, except:[:index, :show, :vote]

  def index
    @post = Post.all.sort_by {|x| x.total_votes}.reverse
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = "Post has been saved."
      redirect_to posts_path
    else
      render :new
    end
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def show
    @comment = Comment.new
    
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "Post has been updated."
      redirect_to posts_path(@post)
    else
      render :edit
    end
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def vote
    Vote.create(voteable: @post, user_id: session[:user_id], vote:params[:vote])
    redirect_to :back, notice: 'Your post vote has been submited.'

  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end

end
