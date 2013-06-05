require 'applications_importer'

class ApplicationsImportsController < ApplicationController
  before_filter :require_http_auth

  layout 'simple'

  def create
    ApplicationsImporter.run(Application, params[:applications_import][:csv])
    redirect_to applications_url
  end
end

