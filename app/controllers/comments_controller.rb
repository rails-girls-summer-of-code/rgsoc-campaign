class CommentsController < ApplicationController
  before_filter :require_http_auth

  def create
    comment = Comment.create!(params[:comment])
    redirect_to comment.application
  end
end
