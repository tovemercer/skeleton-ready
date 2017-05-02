# all entries display
get '/TBD' do
  @TBD = TBD.most_recent
  erb :'TBD/index'
end

# posts new entry to database
post '/TBD' do
  check_login

  @entry = TBD.new(params[:entry])
  @entry.user_id = session[:user_id]

  if @entry.save
    redirect "/TBD/#{@entry.id}"
  else
    @errors = @entry.errors.full_messages
    erb :'TBD/new'
  end
end

# create new entry form
get '/TBD/new' do
  if logged_in?
    erb :'TBD/new'
  else
    redirect "/sessions/new"
  end
end

# show a specfic entry
get '/TBD/:id' do
  @entry = TBD.find(params[:id])
  erb :'TBD/show'
end

# updates a specfic entry
put '/TBD/:id' do
  @entry = TBD.find(params[:id])
  @entry.assign_attributes(params[:entry])

  if current_user != @entry.user
    erb :'not_authorized'
  elsif @entry.save
    redirect "TBD/#{@entry.id}"
  else
    @errors = @entry.errors.full_messages
    erb :'TBD/edit'
  end
end

# deletes a specfic entry
delete '/TBD/:id' do
  @entry = TBD.find(params[:id])

  if current_user != @entry.user
    erb :'not_authorized'
  else
    @entry.destroy
    redirect "/TBD"
  end
end

# gets the edit page for a specfic entry
get '/TBD/:id/edit' do
  @entry = TBD.find(params[:id])

  if current_user != @entry.user
    erb :'not_authorized'
  else
    erb :'TBD/edit'
  end
end
