module ApplicationHelper
  # In dashboard page return the page title + Dashboard
  def dashboard_title(page_title)
    base_title = "Boss Dashboard"

    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
end
