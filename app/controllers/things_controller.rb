class ThingsController < ApplicationController

   get '/things/new' do
     if logged_in
       @user = current_user
         erb :'/things/new'
      else 
        redirect to "/login"
   end
  
   post '/things' do
     @user = current_user
        if params[:thing] == ""
          redirect to "/things/new"
        else   
          @thing = current_user.things.build(params[:thing])
          @thing.user_id = @user.id
          @thing.save
          redirect to "/things/#{@thing.id}"
       end
    end
    
  
   get '/things' do
      if logged_in?
        @user = current_user
        @things = Thing.all
        erb :'/things/things'
      else
        redirect to "/login"
    end
end
  
   
      get '/things/:id' do
         if logged_in?
          @thing = Thing.find_by_id(params[:id])
          @user - User.find(@thing.user_id)
      	   erb :'/things/show'
         else
          redirect to "/login"
        end
     end

      post '/things/:id/edit' do
    	    @thing = Thing.find_by_id(params[:id])
    	     if logged_in? && @thing.user_id == session[:user_id]
    	      erb :'/things/edit'
   	     else
             redirect to "/login"
         end
      end

       patch '/things/:id' do
          @thing = Thing.find(params[:id])
    	   if params[:thing] ==""
	        redirect to "/things/#{params[:id]}/edit"
	      else
      	    @thing.update(thing: params[:thing])
            @thing.save
            redirect to "/things/#{params[:id]}"
          end
       end		  
	
      # delete
       delete '/things/:id/delete' do
         @thing = Thing.find(params[:id])
         @user = current_user
            if logged_in? && @thing.user_id == @user_id
              @thing.delete
            else
          redirect to "/login"
      end
   end
 end
 end
