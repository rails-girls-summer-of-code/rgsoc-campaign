module ApplicationsHelper
  def format_application_project(application)
    project = application.project_name
    project = "#{project} (#{application.project_visibility})" if application.project_visibility
    project
  end
end
