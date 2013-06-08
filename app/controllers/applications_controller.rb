require 'applications_importer'

class ApplicationsController < ApplicationController
  before_filter :require_http_auth
  before_filter :normalize_params, only: :update

  layout 'simple'

  def index
    @applications = Application.includes(:ratings).visible.sort_by(params[:order] || :id)
  end

  def show
    @application = Application.find(params[:id])
    @rating = find_or_initialize_rating
    @data = @rating.data
  end

  def edit
    @application = Application.find(params[:id])
  end

  def update
    application = Application.find(params[:id])
    application.update_attributes!(params[:application])
    redirect_to application
  end

  private

    def find_or_initialize_rating
      attrs = { application_id: @application.id, user_name: session[:user_name] }
      Rating.where(attrs).first || Rating.new(attrs.merge(data: Hashr.new(@application.rating_defaults)))
    end

    def normalize_params
      params[:application][:sponsor_pick] = '' if params[:application][:sponsor_pick].blank?
      params[:application][:data] = params[:application][:data].inject({}) do |data, (key, value)|
        value = nil if value == ''
        data.merge(CGI.unescape(key) => value)
      end
    end
end
