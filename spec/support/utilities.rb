include ApplicationHelper

def sign_in(user, options={})
  if options[:no_capybara]
    session[:remember_token] = user.id
    cookies[:remember_token] = user.id
  else
    visit login_path
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    click_button 'Log In'
  end
end
