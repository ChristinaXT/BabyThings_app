class ThingsController < ApplicationController

   get '/things' do
      if logged_in?
        @user = current_user
        @things = Thing.all
        erb :'things/things'
      else
        redirect "/login"
      end
    end

   
   get '/things/new' do
     if logged_in?
          @user = current_user
          erb :'things/new'
        else
          redirect "/login"
        end
    end
   
    post '/things' do
      	 @user = current_user
      	
      	if logged_in? && params[:content] != ""
      	  @thing = current_user.things.build(content: params[:content])
    	@thing.save
			redirect "/things/#{@thing.id}"
		elsif logged_in? && params[:content] == ""
   		redirect '/things/new'
		else
   		redirect '/login'
 		end
	end
    
   
   
      get '/things/:id' do
        	if logged_in?
         		@thing = Thing.find(params[:id])
      			erb :'/things/show'
         	else
          	redirect '/login'
        	end
     end

      post '/things/:id/edit' do
    	     @thing = Thing.find(params[:id])
    	     if logged_in? && @thing.user_id == current_user.id
    	       erb :'/things/edit'
   	   else
            redirect '/login'
  	     end
 	   end

       patch '/things/:id' do
    	    @thing = Thing.find(params[:id])
  		     if logged_in? && params[:content] != ""
             @thing.update(content: params[:content])
      	      redirect "/things/#{@thing.id}"
              else logged_in? && params[:content] == ""
  		       redirect "/things/#{@thing.id}/edit"   
     	     end
   	  end

         # delete
       post '/things/:id/delete' do
  		   @thing = Thing.find(params[:id])
  		   @user = current_user
  		   if logged_in? && @thing.user_id == @user.id
  			   @thing.delete
  	   	 erb :'/things/delete'
  	     else
  		  redirect '/login'
  	end
  end
end
