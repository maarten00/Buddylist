class BlogpostingsController < ApplicationController
  before_action :set_blogposting, only: [:show, :edit, :update, :destroy]
  before_action :require_login, only: [:show, :index, :create, :new]
  before_action(only: [:show, :edit, :update]) {set_user(@blogposting) }
  before_action(only: [:show]) {get_comments(@blogposting)}
  before_action(only: [:edit]) {require_own_post(@blogposting)}
  autocomplete :tag, :name, :class_name => 'ActsAsTaggable'

  def index
    if params[:tag]
      @blogpostings = Blogposting.tagged_with(params[:tag]).includes(:comments)
    else
      @blogpostings = Blogposting.all.includes(:user).includes(:comments)
    end
  end

  def show
    @comments = @blogposting.comments.all
  end

  def new
    @blogposting = Blogposting.new
  end

  def edit

  end

  def create

    @blogposting = Blogposting.new(user_id: current_user.id, content: blogposting_params['content'], tag_list: blogposting_params['tag_list'])
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

  def destroy
    @blogposting.destroy
    respond_to do |format|
      format.html { redirect_to blogpostings_url }
      format.json { head :no_content }
    end
  end

  private
  def set_blogposting
    @blogposting = Blogposting.find(params[:id])
  end

  private
  def blogposting_params
    params.require(:blogposting).permit(:user_id, :content, :tag_list)
  end

end
