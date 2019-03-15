class ThingsController < ApplicationController

  get '/things' do
      if logged_in?
        @things = Thing.all
        erb :'things/things'
      else
        redirect "/login"
      end
    end

    get '/things/new' do
        if logged_in?
          erb :'things/new'
        else
          redirect "/login"
        end
    end

    post '/things' do
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

      get '/things/:id/edit' do
  	     if logged_in?
    	      @thing = Thing.find(params[:id])
    	       erb :"/things/edit"
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
      delete '/things/:id' do
        if logged_in?
          @thing = Thing.find(params[:id])
        if @thing.user == current_user
           @thing.delete
        else
          redirect '/things'
        end
        else
          redirect '/login'
        end
      end
 end
