
class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!


  #create and save recipe
  #paired - new(12) & create(16) -- new always create 
  get "/recipes/new" do 
    erb :new 
  end 

  post "/recipes" do 
    @recipe = Recipe.new(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    if @recipe.save 
      #binding.pry
      redirect to "/recipes/#{@recipe.id}"
    else
      redirect to "/recipes/new" 
    end  
  end 

  #use restful route to display a single recipe
  #erb show
  get "/recipes/:id" do 
    @recipe = Recipe.find_by_id(params[:id])
    if @recipe 
      erb :show 
    else 
      redirect "/recipes"
    end 
  end 

  #use restful route render a form to edit a single recipe
  #update entry in database then redirect to recipe show page
  #erb edit 
  get "/recipes/:id/edit" do 
    @recipe = Recipe.find_by_id(params[:id])
    if @recipe 
      erb :edit
    else 
      redirect "/recipes"
    end 
  end 

  patch "/recipes/:id" do 
    @recipe = Recipe.find_by_id(params[:id])
    if @recipe.update(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
      redirect to "/recipes/#{@recipe.id}"
    else   
      redirect to "/recipes/#{@recipe.id}/edit"
    end 
    #@recipe.name = params[:name]
    #@recipe.ingredients = params[:ingredients]
    #@recipe.cook_time = params[:cook_time]
    #@recipe.save 
  end 


  get "/recipes" do 
    #display all recipes in database
    @recipes = Recipe.all
    erb :index
  end 

  #recipe show page - form to delete an entry 
  #controller should delete recipe and redirect to index page
  delete "/recipes/:id" do 
    @recipe = Recipe.find_by_id(params[:id])
    if @recipe 
      @recipe.delete
    end 
    redirect to "/recipes"
  end 

end
