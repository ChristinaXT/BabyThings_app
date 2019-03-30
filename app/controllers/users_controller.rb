class UsersController < ApplicationController


   get "/signup" do
      if !User.exists?(session[:user_id])
        erb :'/users/create_user'
      else
        @user = current_user
        redirect "/users/#{current_user.id}"
     end
    end
  
  post '/signup' do
    if params.values.any? {|value| value == ""}
      erb :'users/create_user'
    else
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to "/things"
    end
  end
  
  get '/users/:id' do
      @user = User.find(params[:id])
      	erb :'/users/show'
    end
  end
  
  get '/login' do
    if !User.exists?(session[:user_id])
        erb :'/users/login'
    else
      redirect to "/things"
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
      if @user && @user.authenticate(params[:password])
	     session[:user_id] = @user.id 
	     redirect "/users/#{@user.id}"
      else
	     redirect to "users/login" 
      end
  end

  get "/logout" do
      if !User.exists?(session[:user_id])
        redirect "/"
      else
        session.clear
        redirect "/login"
      end
  end
  
