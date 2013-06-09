class ApplicationsImportsController < ApplicationController
  before_filter :require_http_auth

  layout 'simple'

  def create
    Application.import(params[:applications_import][:csv])
    redirect_to applications_url
  end
end

