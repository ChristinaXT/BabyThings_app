require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_secret"
  end

   get '/' do
     erb :'index'
   end

  helpers do
    def logged_in?
      !!session[:user_id]
  	end


    def current_user
  		 User.find(session[:user_id])
  	end

    def redirect_if_not_logged_in
      unless logged_in?
        redirect to "/login"
       end
    end
  end
end
