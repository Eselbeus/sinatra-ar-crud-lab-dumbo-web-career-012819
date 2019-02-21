
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :method_override, true
  end

  get '/' do
    @articles = Article.all
    # binding.pry
    erb :index
  end
  
  get '/articles/new' do
    erb :new
  end
  
  get '/articles' do
    @articles = Article.all
    # binding.pry
    erb :index
  end
  
  post '/articles' do 
    new_article = Article.create(params)
    # binding.pry
    redirect to "/articles/#{new_article.id.to_s}"
  end
  
  get '/articles/:id' do
    @article = Article.find(params[:id])
    # binding.pry
    erb :show
  end
  
  get '/articles/:id/edit' do
    @article = Article.find(params[:id])
    # binding.pry
    erb :edit
  end
  
  # post '/articles/:id/edit' do 
  #   erb :edit
  # end
  
  patch '/articles/:id' do 
    @article = Article.find(params[:id])
    @article.title = params[:title]
    @article.content = params[:content]
    @article.save
    # binding.pry
    redirect to "/articles/#{@article.id.to_s}"
  end
  
  delete '/articles/:id' do
    @article = Article.find(params[:id])
	  @article.delete

    erb :index
  end
end
