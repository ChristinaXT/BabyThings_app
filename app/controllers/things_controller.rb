class ThingsController < ApplicationController

   get '/things' do
      if logged_in?
        @things = Thing.all
        erb :'things/things'
      else
        erb :'users/login', locals: {message: "You don't have access, please login"}
      end
    end

   
   get '/things/new' do
     if logged_in?
        erb :'things/new'
     else
         erb :'users/login', locals: {message: "You don't have access, please login"}
     end
   end
   
    post '/things' do
       if params.values.any? {|value| value == ""}
         erb :'projects/new', locals: {message: "Please try again"}
       else   
	  user = User.find(session[:user_id])
      	  @thing = Thing.create(content: params[:content] user_id: user.id)
    	  redirect "/things/#{@thing.id}"
       end
    end
    
      get '/things/:id' do
         if logged_in?
         @thing = Thing.find(params[:id])
      	   erb :'/things/show'
         else
          erb :'users/login', locals: {message: "Please try again"}
        end
     end

      get '/things/:id/edit' do
	 if logged_in?
    	   @thing = Thing.find(params[:id])
    	   if @thing.user_id == session[:user_id]
    	      erb :'/things/edit'
   	   else
              erb :'things', locals: {message: "You don't have access to edit list"}
           end
         else
             erb :'users/login', locals: {message: "Please login"}
         end
      end

       patch '/things/:id' do
    	  if params.values.any? {|value| value == ""}
	     redirect to "/things/#{params[:id]}/edit"
	  else
            @thing = Thing.find(params[:id])
      	    @thing.content = params[:content]
            @thing.save
            redirect to "/things/#{@thing.id}"
          end
       end		  
	
      # delete
       delete '/things/:id/delete' do
         @thing = Thing.find(params[:id])
  	if session[:user_id]
          @thing = Thing.find(params[:id])
           if @thing.user_id == session[:user_id]
              @thing.delete
              redirect to '/things'
           else
              redirect to '/things'
           end
       else
          redirect to '/login'
      end
   end

end
