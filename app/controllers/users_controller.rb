require 'jwt'

class UsersController < ApplicationController

  def index
    movies = Movie.all
    nominations = Nomination.all
    token = request.headers[:Authorization].split(' ')[1]
        decoded_token = JWT.decode token, 'secret', true, { algorithm: 'HS256' }
        user_id = decoded_token[0]['user_id']
        user = User.find(user_id)
        if user 
            render json: { user: {id: user.id, username: user.username }, nominations: nominations, movies: movies, my_movies: user.movies }
        else 
            render json: { error: 'Invalid Credentials' }, status: 401
        end 
  end

  def create
    user = User.create(username: params['username'], password: params['password'])
        payload = { user_id: user.id }
        token = JWT.encode(payload, 'secret', 'HS256')
        if user.valid?
            render json: { id: user.id, username: user.username, token: token }, status: :created
        else
            render json: { error: 'failed to create user' }, status: :not_acceptable
        end
  end

  def update
    user = User.find_by(username: params['username'])
    if user
        payload = { user_id: user.id }
        token = JWT.encode(payload, 'secret', 'HS256')
        if user && user.authenticate(params[:password])
            render json: { id: user.id, username: user.username, token: token, my_movies: user.movies }
        else 
            render json: { error: 'Invalid Credentials' }, status: 401
        end
    else
        render json: { error: 'Invalid Credentials' }, status: 401
    end
  end

end
