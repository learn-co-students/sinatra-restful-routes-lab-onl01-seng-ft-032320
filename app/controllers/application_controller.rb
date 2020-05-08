class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!

  get '/recipes' do      #index
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do       #new
    erb :new
  end

 get '/recipes/:id' do      #show
 
  @recipe = Recipe.find_by_id(params[:id])
  
    erb :show
  end
  
  
  post '/recipes' do          #create
   
    @recipe = Recipe.create(params)
    
    redirect "/recipes/#{@recipe.id}"
  end
  #name: params[:name], ingredients: params[:ingredients], cook_time: params[cook_time]

  get '/recipes/:id/edit' do      #edit
    @recipe = Recipe.find_by_id(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do      #update
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.update(title: params[:title], content: params[:content])
    redirect "/recipes/#{@recipe.id}"
  end

  delete '/recipes/:id' do      #delete
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.delete
    erb :index
  end

end
