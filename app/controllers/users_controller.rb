class UsersController < ApplicationController


  get '/signup' do
    if !logged_in?
    erb :'/users/create_user'
   else
    redirect to "/things"
    end
  end

  post '/signup' do
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      if params.values.any? {|value| value == ""}
      erb :'/users/create_user'
    elsif User.username_check(@user.username)
      redirect to "/signup"
     else
       @user.save
       session[:user_id] = @user.id
        redirect to "/users/#{@user.id}"
     end
  end

  get '/users/:id' do
    if logged_in?
      @user = current_user
      @things = current_user.things
      erb :'/users/show'
     else
       redirect to "/login"
    end
  end

  get '/login' do
    if !logged_in?
     erb :'/users/login'
    else
      redirect to "/things"
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/things"
  else
      redirect to "/login"
    end
  end

   get '/logout' do
    if session[:user_id] != nil
      session.destroy
      redirect to "/"
  else
      redirect to "/things"
    end
  end

end
