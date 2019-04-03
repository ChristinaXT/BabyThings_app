class UsersController < ApplicationController


   get '/signup' do
       if !logged_in?
        erb :'/users/create_user'
      else
        redirect to "/things"
     end
    end
  
  post '/signup' do
    if params.values.any? {|value| value == ""}
      erb :'/users/create_user'
    else
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to "/users/#{@user.id}"
    end
  end
  
  get '/users/:id' do
      @user = User.find(params[:id])
      	erb :'/users/show'
  end
  
  get '/login' do
    if !User.exists?(session[:user_id])
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
     if !User.exists?(session[:user_id])
        redirect "/"
      else
        session.clear
        redirect to "/login"
      end
    end


 end 
