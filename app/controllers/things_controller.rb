class ThingsController < ApplicationController

 get '/things' do
    if logged_in?
      @things = Thing.all
      erb :'/things/things'
    else
      redirect to "/login"
    end
 end
  
  get '/things/new' do
     if logged_in?
         erb :'/things/new'
      else 
        redirect to "/login"
   end
 end

    post '/things' do
      if params.values.any? {|value| value == ""}
          redirect to "/things/new"
        else  
      	  @thing = Thing.create(content: params[:content])
      	  @thing.user_id = current_user.id
      	  @thing.save
          redirect to "/things/#{@thing.id}"
       end
    end
 
      get '/things/:id' do
         if logged_in?
           @thing = Thing.create(content: params[:content])
      	   @thing.user_id = current_user.id
          #@thing = current_user.things.find(params[:user_id])
      	   erb :'/things/show'
         else
          redirect to "/login"
        end
     end

      get '/things/:id/edit' do
    	    @thing = Thing.find(params[:id])
    	     if @thing.user_id == session[:user_id]
    	      erb :'/things/edit'
   	     else
             redirect to "/login"
         end
      end

       patch '/things/:id' do
         @thing = Thing.find(params[:id])
          if params.values.any? {|value| value == ""}
	         redirect to "/things/#{params[:id]}/edit"
	        else
	         if @thing.user_id = current_user.id
	           @thing.update(params[:content])
      	     @thing.content = params[:content]
             @thing.save
              redirect to "/things/#{@thing.id}"
          end
       end		  
	
      # delete
       delete '/things/:id/delete' do
         @thing = Thing.find(params[:id])
            if @thing.user_id == session[:user_id]
              @thing.delete
           end
             redirect to "/things"
        end
   end
end