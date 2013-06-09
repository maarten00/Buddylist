class AudiopostingsController < ApplicationController
  before_action :set_audioposting, only: [:show, :edit, :update, :destroy]
  before_filter :require_login, only: [:show]
  before_filter :set_user, only: [:show]
  before_filter :get_user, only: [:create]
  before_action :get_comments, only: [:show]

  # GET /audiopostings
  def index
    if params[:tag]
      @audiopostings = Audioposting.tagged_with(params[:tag]).includes(:comments)
    else
      @audiopostings = Audioposting.all.includes(:user).includes(:comments)
    end
  end

  # GET /audiopostings/1
  def show
  end

  # GET /audiopostings/new
  def new
    @audioposting = Audioposting.new
  end

  # GET /audiopostings/1/edit
  def edit
  end

  # POST /audiopostings
  def create
    @audioposting = Audioposting.new(audioposting_params)

    if @audioposting.save
      redirect_to @audioposting, notice: 'Audioposting was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /audiopostings/1
  def update
    if @audioposting.update(audioposting_params)
      redirect_to @audioposting, notice: 'Audioposting was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /audiopostings/1
  def destroy
    @audioposting.destroy
    redirect_to audiopostings_url, notice: 'Audioposting was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_audioposting
      @audioposting = Audioposting.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def audioposting_params
      params.require(:audioposting).permit(:audiofile)
    end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_audioposting
    @audioposting = Audioposting.find(params[:id])
  end

  private
  def get_comments
    @comments = @audioposting.comments.all
  end

  private
  def set_user
    @user = User.find(@audioposting.user_id)
  end

  private
  def get_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  private
  def audioposting_params()
    params.require(:audioposting).permit(:user_id, :audiofile, :tag_list).merge(:user_id => @user.id)
  end
end
