require 'applications_importer'

class ApplicationsController < ApplicationController
  before_filter :require_http_auth

  layout 'simple'

  def index
    @applications = Application.order(:timestamp)
  end

  def show
    @application = Application.find(params[:id])
  end
end
