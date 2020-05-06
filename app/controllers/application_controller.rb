class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    recipe = Recipe.new(params)
    if recipe.save
      redirect "/recipes/#{recipe.id}"
    else
      redirect '/recipes/new'
    end
  end

  get '/recipes/:id' do
    @recipe = Recipe.find_by(id: params[:id])
    if @recipe
      erb :show
    else
      redirect '/recipes'
    end
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by(id: params[:id])
    if @recipe
      erb :edit
    else
      redirect '/recipes'
    end
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find_by(id: params[:id])
    if @recipe.update(params.except(:id, :_method))
      redirect "/recipes/#{recipe.id}"
    else
      redirect "/recipes/#{recipe.id}/edit"
    end
  end

  delete '/recipes/:id' do
    @recipe = Recipe.find_by(id: params[:id])
    @recipe.delete
    redirect "/recipes"
  end
  
end