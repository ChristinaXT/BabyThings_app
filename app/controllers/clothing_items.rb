class ClothingItemsController < ApplicationController

  get '/clothing_items' do
      if logged_in?
        @clothing_items = Clothing_item.all
        erb :'clothing_items/clothing_items'
      else
        redirect "/login"
      end
    end

    get '/clothing_items/new' do
        if logged_in?
          erb :'clothing_items/new'
        else
          redirect "/login"
        end
    end

    post '/clothing_items' do
      	if logged_in? && params[:content] != ""
        	@clothing_item = current_user.clothing_items.build(content: params[:content])
        	@clothing_item.save
    			redirect "/clothing_items/#{@clothing_item.id}"
    		elsif logged_in? && params[:content] == ""
       		redirect '/clothing_items/new'
    		else
       		redirect '/login'
     		end
    	end

      get '/clothing_items/:id' do
        	if logged_in?
         		@clothing_item = Clothing_item.find(params[:id])
      			erb :'/clothing_items/show'
         	else
          	redirect '/login'
        	end
       	end

      get '/clothing_items/:id/edit' do
  	     if logged_in?
    	      @clothing_item = Clothing_item.find(params[:id])
    	       erb :"/clothing_items/edit"
   	     else
             redirect '/login'
  	     end
 	     end

       patch '/clothing_items/:id' do
    	    @clothing_item = Clothing_item.find(params[:id])
  		     if logged_in? && params[:content] != ""
      	      @clothing_item.update(content: params[:content])
      	       redirect "/clothing_items/#{@clothing_item.id}"
  		     else logged_in? && params[:content] == ""
      	       redirect "/clothing_items/#{@clothing_item.id}/edit"
     	     end
   	     end

         # delete
      delete '/clothing_items/:id' do
        if logged_in?
          @clothing_item = Clothing_item.find(params[:id])
        if @clothing_item.user == current_user
           @clothing_item.delete
        else
          redirect '/clothing_items'
        end
        else
          redirect '/login'
        end
      end
 end
