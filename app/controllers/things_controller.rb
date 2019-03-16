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
      	if logged_in? && params[:content] == ""
      	  redirect '/things/new'
      	else
        	@thing = Thing.create(content: params[:content])
        	@thing.save
    			redirect "/things/#{@thing.id}"
     		end
    	end

    

      get '/things/:id' do
        	if logged_in?
         		@thing = Thing.find(params[:id])
         		@user = User.find(@thing.user_id)
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

       post '/things/:id' do
    	    @thing = Thing.find(params[:id])
  		     if params[:content] == ""
  		       redirect "/things/#{@thing.id}/edit"
  		     else
      	      @thing.update(content: params[:content])
      	       redirect "/things/#{@thing.id}"
      	       
     	     end
   	     end

         # delete
      post '/things/:id/delete' do
          @thing = Thing.find(params[:id])
          @user = current_user
          if logged_in? && @thing.user_id == @user.id
           @thing.delete
          redirect '/things'
        else
          redirect '/login'
        end
      end
 end
