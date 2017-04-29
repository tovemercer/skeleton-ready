# user login
get '/sessions/new' do
  erb :'sessions/new'
end

# authenticates user & logs them in
post '/sessions' do
  user = User.authenticate(params[:email], params[:password])

  if user
    session[:user_id] = user.id
    redirect "/users/#{user.id}"
  else
    @errors = ["Incorrent login info"]
    erb :'sessions/new'
  end
end

# deletes session
delete '/sessions' do
  session[:user_id] = nil
  redirect "/"
end
