
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :new
  end

  #new
  get "/articles/new" do
    #@article = Article.new
    erb :new
  end

  #create
  post "/articles" do
    @article = Article.create(params)
    redirect "/articles/#{@article.id}"
  end

  #read
  get "/articles" do
    @articles = Article.all

    erb :index
  end

  get "/articles/:id" do
    @article = Article.find(params[:id])
    erb :show
  end

  # #update
  get "/articles/:id/edit" do
    @article = Article.find(params[:id])
    erb :edit
  end
  #
  patch "/articles/:id" do
    params.delete("_method")
    @article = Article.find(params[:id])
    @article.update(title: params[:title], content: params[:content])
    @article.save
    redirect to "/articles/#{@article.id}"

  end

  #delete
  delete '/articles/:id' do
      params.delete("_method")
      @article = Article.find(params[:id])
      @article.destroy
    erb :index
  end

end
