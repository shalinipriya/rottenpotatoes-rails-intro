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
    @movies = Movie.all
	@all_ratings =  Movie.all_ratings
	if(params[:ratings])
		@ratings_checked = params[:ratings] || {}
	else
		params[:ratings] = session[:ratings]
		@ratings_checked = params[:ratings]||{}
		if(!params[:ratings])
			@ratings_checked = {"G"=>1, "R"=>1, "PG"=>1, "PG-13"=>1}
			params[:ratings] = @ratings_checked
		end
	end
	array_ratings = params[:ratings].collect {|key,value| key }
	@movies = Movie.where(rating: array_ratings)
	if(!params[:sort]&&session[:sort])
		params[:sort] = session[:sort]
	end
	sort = params[:sort]
	if sort=='title' 
		@movies = @movies.sort_by{|i| i.title}
	elsif sort=='release'
		@movies = @movies.sort_by{|i| i.release_date.to_s}
	end
	session[:sort] = params[:sort]
	session[:ratings]=params[:ratings]

	
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
