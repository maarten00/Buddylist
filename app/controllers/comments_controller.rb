class CommentsController < ApplicationController
  before_filter :require_login

  # create a comment and bind it to an article and a user
  def create
    @blogposting = Blogposting.find(params[:blogposting_id])
    @comment = @blogposting.comments.build(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to(@blogposting, :notice => 'Comment was successfully created.') }
      else
        format.html { redirect_to(@blogposting, :notice => 'There was an error saving your comment (empty comment or comment way to long).') }
      end
    end
  end

  # remove a comment
  def destroy
    @comment = current_user.comments.find(params[:id])
    @blogposting = Blogposting.find(params[:blogposting_id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to @blogposting }
    end
  end

  private
  def comment_params
    params.required(:comment).permit(:content)
  end
end
