class BlogpostingsController < ApplicationController
  before_filter :set_blogposting, only: [:show, :edit, :update, :destroy]
  before_filter :require_login, only: [:show, :index, :create, :new]
  before_filter :set_user, only: [:show]
  before_action :get_comments, only: [:show]
  autocomplete :tag, :name, :class_name => 'ActsAsTaggable'

  # GET /blogpostings
  # GET /blogpostings.json
  def index
    if params[:tag]
      @blogpostings = Blogposting.tagged_with(params[:tag]).includes(:comments)
    else
      @blogpostings = Blogposting.all.includes(:user).includes(:comments)
    end
  end

  # GET /blogpostings/1
  # GET /blogpostings/1.json
  def show
    @comments = @blogposting.comments.all
  end

  # GET /blogpostings/new
  def new
    @blogposting = Blogposting.new
  end

  # GET /blogpostings/1/edit
  def edit

  end

  # POST /blogpostings
  # POST /blogpostings.json
  def create

    @blogposting = Blogposting.new(user_id: current_user.id, content: blogposting_params['content'], tag_list: blogposting_params['tag_list'])
    #@blogpostingstag = BlogpostingsTag.new(blogposting_params)
    #@tag = Tag.new(blogposting_params)
    respond_to do |format|
      if @blogposting.save
        format.html { redirect_to @blogposting, notice: 'Blogposting was successfully created.' }
        format.json { render action: 'show', status: :created, location: @blogposting }
      else
        format.html { render action: 'new' }
        format.json { render json: @blogposting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogpostings/1
  # PATCH/PUT /blogpostings/1.json
  def update
    respond_to do |format|
      if @blogposting.update(blogposting_params)
        format.html { redirect_to @blogposting, notice: 'Blogposting was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @blogposting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogpostings/1
  # DELETE /blogpostings/1.json
  def destroy
    @blogposting.destroy
    respond_to do |format|
      format.html { redirect_to blogpostings_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_blogposting
    @blogposting = Blogposting.find(params[:id])
  end

  private
  def get_comments
    @comments = @blogposting.comments.all
  end

  private
  def set_user
    @user = User.find(@blogposting.user_id)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  private
  def blogposting_params
    params.require(:blogposting).permit(:user_id, :content, :tag_list)
  end

end
