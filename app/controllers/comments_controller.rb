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
    @post = Post.find_by(slug: params[:post_id])
    @comment = Comment.find(params[:id])

    @vote = Vote.create(voteable: @comment, user_id: session[:user_id], vote: params[:vote])
    

     respond_to do |format|
      format.html do
        if @vote.valid?
         flash[:notice] = 'Your post vote has been submited.' 
       else
          flash[:error] = 'Your vote has already been counted.'
        end
          redirect_to :back
      end
      format.js 
    end

end


end
