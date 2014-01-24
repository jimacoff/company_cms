crumb :root do
  link 'Home', boss_path
end

crumb :services do
  link 'Services', services_path
end

crumb :edit_service do |service|
  link "Edit #{service.name}", edit_service_path(service)
  parent :services
end

crumb :new_service do
  link 'New Service', new_service_path
  parent :services
end

crumb :team_members do
  link 'Team Members', team_members_path
end

crumb :edit_team_member do |member|
  link "Edit #{member.name}", edit_team_member_path(member)
  parent :team_members
end

crumb :new_team_member do
  link 'New Team Member', new_team_member_path
  parent :team_members
end

crumb :works do
  link 'Works', works_path
end

crumb :work do |work|
  link work.name, work_path(work)
  parent :works
end

crumb :edit_work do |work|
  link 'Edit', edit_work_path(work)
  parent :work, work
end

crumb :new_work do |work|
  link 'New Work', new_work_path
  parent :works
end

crumb :new_task do |work|
  link 'New Task', new_work_task(work)
  parent :work, work
end

crumb :edit_task do |task|
  link "Edit Task #{task.title}", edit_task_path(task)
  parent :work, task.work
end

crumb :messages do
  link 'Messages', messages_path
end

crumb :blog do
  link 'Blog', posts_path
end

crumb :edit_post do |post|
  link 'Edit Blog Post', edit_post_path(post)
  parent :blog
end

crumb :new_post do
  link 'New Blog Post', new_post_path
  parent :blog
end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).
