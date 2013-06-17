class FilepostingsController < ApplicationController
  before_action :set_fileposting, only: [:show, :edit, :update, :destroy]
  before_action :require_login, only: [:show, :index, :edit, :create, :new]
  before_action(only: [:show, :edit, :update]) {set_user(@fileposting) }
  before_action(only: [:show]) {get_comments(@fileposting)}
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
  def set_fileposting
    @fileposting = Fileposting.find(params[:id])
  end

  private
  def fileposting_params()
    params.require(:fileposting).permit(:user_id, :file, :title, :tag_list, :filetype).merge(user_id: current_user.id)
  end
end
