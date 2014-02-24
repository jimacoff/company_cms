namespace :db do
  desc "Fill database with service sample data"

  task default_categories: :environment do
    # Reset the database
    WorkCategory.delete_all

    # Create the category array
    categories_name = ['Web Development', 'Mobile Development', 'Graphic Design/Print Design']

    categories_name.each do |name|
      WorkCategory.create! name: name
    end
  end
end
