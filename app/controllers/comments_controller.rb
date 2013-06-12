class CommentsController < ApplicationController
  before_filter :require_login
  before_filter :set_posting

  # create a comment and bind it to an article and a user
  def create
    @comment = @posting.comments.build(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to(@posting, :notice => 'Comment was successfully created.') }
      else
        format.html { redirect_to(@posting, :notice => 'There was an error saving your comment (empty comment or comment way to long).') }
      end
    end
  end

  # remove a comment
  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to @posting }
    end
  end

  private
  def comment_params
    params.required(:comment).permit(:content)
  end

  private
  def set_posting
    if params['fileposting_id']
      @posting = fileposting.find(params['fileposting_id'])
    else
      params['blogposting_id']
      @posting = Blogposting.find(params['blogposting_id'])
    end
  end

end
