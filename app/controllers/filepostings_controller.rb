class FilepostingsController < ApplicationController
  before_action :set_fileposting, only: [:show, :edit, :update, :destroy]
  before_filter :require_login, only: [:show, :index, :edit, :create]
  before_filter :set_user, only: [:show, :edit, :update]
  before_filter :get_user, only: [:create]
  before_action :get_comments, only: [:show]
  autocomplete :tag, :name, :class_name => 'ActsAsTaggable'

  # GET /filepostings
  def index
    if params[:tag]
      @filepostings = Fileposting.tagged_with(params[:tag]).includes(:comments)
    else
      @filepostings = Fileposting.all.includes(:user).includes(:comments)
    end
  end

  # GET /filepostings/1
  def show
  end

  # GET /filepostings/new
  def new
    @fileposting = Fileposting.new
  end

  # GET /filepostings/1/edit
  def edit
  end

  # POST /filepostings
  def create
    @fileposting = Fileposting.new(fileposting_params)

    if @fileposting.save
      redirect_to @fileposting, notice: 'Fileposting was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /filepostings/1
  def update
    if @fileposting.update(fileposting_params)
      redirect_to @fileposting, notice: 'Fileposting was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /filepostings/1
  def destroy
    @fileposting.destroy
    redirect_to fileposting_url, notice: 'Fileposting was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_fileposting
    @fileposting = Fileposting.find(params[:id])
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_fileposting
    @fileposting = Fileposting.find(params[:id])
  end

  private
  def get_comments
    @comments = @fileposting.comments.all
  end

  private
  def set_user
    @user = User.find(@fileposting.user_id)
  end

  private
  def get_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  private
  def fileposting_params()
    params.require(:fileposting).permit(:user_id, :file, :title, :tag_list, :filetype).merge(user_id: @user.id)
  end
end
