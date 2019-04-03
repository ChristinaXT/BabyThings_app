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
          erb :'/things/new'
        else  
          user = User.find(session[:user_id])
      	  @thing = Thing.create(content: params[:content])
      	  @thing = Thing.create(user_id: params[:user_id])
          redirect to "/things/#{@thing.id}"
       end
    end
 
      get '/things/:id' do
         if logged_in?
          @thing = Thing.find(params[:id])
      	   erb :'/things/show'
         else
          redirect to "/login"
        end
     end

      post '/things/:id/edit' do
    	    if logged_in?
    	    @thing = Thing.find(params[:id])
    	     if @thing.user_id == session[:user_id]
    	      erb :'/things/edit'
   	     else
             redirect to "/login"
         end
      end

       post '/things/:id' 
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
