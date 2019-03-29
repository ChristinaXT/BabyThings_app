class UsersController < ApplicationController


  get '/signup' do
    if !logged_in?
	erb :'users/create_user'
    else
	redirect "/things"		
    end
  end
  
  post '/signup' do
    if params.values.any? {|value| value == ""}
      erb :'users/create_user', {message: "Please try again"}
    else
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to "/things"
    end
  end
  
  get '/login' do
    if !logged_in?
      erb :'users/login'
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
	     erb :'users/login', {message: "Please try again"}
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

  get '/users/:id' do
    if logged_in?
      @user = User.find(params[:id])
      	erb :'/users/show'
   else
       redirect to "users/login", {message: "Please try again"}
   end
 end

end
