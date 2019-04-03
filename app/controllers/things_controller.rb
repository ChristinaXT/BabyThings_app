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
       @user = current_user
         erb :'/things/new'
      else 
        redirect to "/login"
   end
 end

    post '/things' do
      if params.values.any? {|value| value == ""}
          erb :'/things/new'
        else  
         @user = User.find(@thing.user_id)
          @thing = Thing.create(content: params[:content], user_id: user.id)
          redirect to "/things/#{@thing.id}"
       end
    end
 
      get '/things/:id' do
         if logged_in?
          @thing = Thing.find_by_id(params[:id])
          @user = User.find(@thing.user_id)
      	   erb :'/things/show'
         else
          redirect to "/login"
        end
     end

      get '/things/:id/edit' do
    	    @thing = Thing.find_by_id(params[:id])
    	     if logged_in? && @thing.user_id == session[:user_id]
    	      erb :'/things/edit'
   	     else
             redirect to "/login"
         end
      end

       patch '/things/:id' 
       if params.values.any? {|value| value == ""}
          @thing = Thing.find(params[:id])
	        redirect to "/things/#{params[:id]}/edit"
	      else
	          @thing = Thing.find(params[:id])
      	    @thing.update(thing: params[:thing])
            @thing.save
            redirect to "/things/#{@thing.id}"
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
 
