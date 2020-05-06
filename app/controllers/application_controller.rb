# require "./config/enviroment"
# require "./app/models/recipe"

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    @recipe = Recipe.new(params)
    if @recipe.save
      redirect :"/recipes/#{@recipe.id}"
    else 
      redirect :'/recipes/new'
    end
  end
  
  get '/recipes' do
    @recipe = Recipe.all
     erb :index
  end

  get '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    if @recipe
      erb :show 
    else
      redirect :'/recipes'
    end
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by_id(params[:id])
    if @recipe
      erb :edit
    else
      redirect :'/recipes'
    end
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    if @recipe.update(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
      redirect :"/recipes/#{@recipe.id}"
    else
      redirect :"/recipes/#{@recipe.id}/edit"
    end
  end


  delete '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    if @recipe
      @recipe.delete
    end
    redirect to '/recipes'
  end
  

end
