def current_user
  @current_user ||= User.find_by(id: session[:user_id])
end

def logged_in?
  session[:user_id] != nil
end

# authenticates user
def check_login
  redirect "/sessions/new" unless logged_in?
end

def user_is_author?(author)
  current_user == author
end
