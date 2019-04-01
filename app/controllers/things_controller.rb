class ThingsController < ApplicationController

   get '/things' do
      if logged_in?
        @things = Thing.all
        erb :'things/things'
      else
        redirect to "users/login", {message: "You don't have access, please login"}
      end
    end

   get '/things/new' do
     if !logged_in?
         redirect to "users/login"  
     end
         erb :'things/new'
   end
   
    post '/things' do
       if params.values.any? {|value| value == ""}
         erb: "things/new" 
       else   
      	  @thing = Thing.create(content: params[:content], user_id: current_user.id)
      	  @thing.save
    	    redirect to "/things/#{@thing.id}"
       end
    end
    
      get '/things/:id' do
         if logged_in?
          @thing = Thing.find(params[:id]
      	   erb :'/things/show'
         else
          redirect to "users/login", {message: "Please try again"}
        end
     end

      get '/things/:id/edit' do
	       if logged_in?
    	    @thing = Thing.find_by_id(params[:id])
    	     if @thing.user_id == session[:user_id]
    	      erb :'/things/edit'
   	     else
              redirect to "things/things", {message: "You don't have access to edit list"}
           end
         else
             redirect to "users/login", {message: "Please login"}
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
              redirect to "/things"
            else
              redirect to "/things"
            end
          else
          redirect to "/login"
      end
   end

end
