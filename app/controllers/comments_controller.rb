class CommentsController < ApplicationController
  before_action :require_user

def create
  @post = Post.find_by(slug: params[:post_id])
  @comment = @post.comments.new(params.require(:comment).permit(:body))

    if @comment.save
      flash[:notice] = 'Comment has been saved'
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
end

def vote
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])

   Vote.create(voteable: @comment, user_id: session[:user_id], vote: params[:vote])
    redirect_to :back, notice: "Your comment vote has been submited."
end


end
