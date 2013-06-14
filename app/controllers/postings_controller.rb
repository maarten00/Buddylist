class PostingsController < ApplicationController
  before_action :require_login, only: [:index]

  def index
    @filepostings = Fileposting.all.includes(:user).includes(:comments)
    @blogpostings = Blogposting.all.includes(:user).includes(:comments)
    merge_and_sort_postings
  end

end