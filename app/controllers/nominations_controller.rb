class NominationsController < ApplicationController

  def index
    nominations = Nomination.all
    movies = Movie.all
    render json: {nominations: nominations, movies: movies}
  end

  def create
   movies = Movie.all
   movie = movies.find_by(title: params['title'])
   user = User.all.find(params['user_id'])
   if movie
    nomination = Nomination.create(user_id: user.id, movie_id: movie.id)
   else 
    new_movie = Movie.create(title: params['title'], year: params['year'])
    nomination = Nomination.create(user_id: user.id, movie_id: new_movie.id)
   end 
   if nomination.valid?
    render json: { nominations: Nomination.all, movies: Movie.all, my_movies: user.movies }
   else
    render json: { error: 'Nomination not created'}, status: 401
   end 
  end

  def destroy
    nomination = Nomination.all.find(params['id'])
    nomination.destroy
    nominations = Nomination.all
    user = User.all.find(params['user_id'])
    render json: {nominations: nominations, my_movies: user.movies}
  end

end
