# registration form
get '/users/new' do
  erb :'users/new'
end

# creates a new user in the database and sets the session
post '/users' do
  new_user = User.new(params[:user])
  new_user.password = params[:password]

  if new_user.save
    session[:user_id] = new_user.id
    redirect "/users/#{new_user.id}"
  else
    @errors = new_user.errors.full_messages
    erb :'users/new'
  end
end

#user homepage
get '/users/:id' do
  check_login

  @user = User.find(params[:id])
  # @entries = @user.entries
  if @user
    erb :'users/show'
  else
    # erb :'404' #need an error erb page if using this
    # or
    redirect "/users/new"
  end
end
