class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    options = Movie.selected(params,session)
    
    
    if options[:redirect]
      flash.keep
      
      redirect_to(
        :action => params[:action], :controller => params[:controller],
        :ratings => options[:ratings], :sort => options[:sort]
        
      )
    end
    
    
   
    @all_ratings = Movie.all_ratings
    @sort = options[:sort]
    @filter = options[:ratings]
    @movies = Movie.movies(@filter, options[:sort])
    
    session[:ratings] = options[:ratings]
    session[:sort] = options[:sort]
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
  
end
