require 'applications_importer'

class ApplicationsController < ApplicationController
  before_filter :require_http_auth

  layout 'simple'

  def index
    @applications = Application.includes(:ratings).sort_by(params[:order] || :id)
  end

  def show
    @application = Application.find(params[:id])
    @rating = find_or_initialize_rating
    @data = @rating.data
  end

  private

    def find_or_initialize_rating
      attrs = { application_id: @application.id, user_name: session[:user_name] }
      Rating.where(attrs).first || Rating.new(attrs.merge(data: Hashr.new(@application.rating_defaults)))
    end
end
