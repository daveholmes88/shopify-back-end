class NominationsController < ApplicationController
  before_action :set_nomination, only: [:show, :edit, :update, :destroy]

  # GET /nominations
  # GET /nominations.json
  def index
    @nominations = Nomination.all
  end

  # GET /nominations/1
  # GET /nominations/1.json
  def show
  end

  # GET /nominations/new
  def new
    @nomination = Nomination.new
  end

  # GET /nominations/1/edit
  def edit
  end

  # POST /nominations
  # POST /nominations.json
  def create
   movies = Movie.all
   movie = movies.find_by(title: params['title'])
   if movie
    nomination = Nomination.create(user_id: params['user_id'], movie_id: movie.id)
   else 
    new_movie = Movie.create(title: params['title'], year: params['year'])
    nomination = Nomination.create(user_id: params['user_id'], movie_id: new_movie.id)
   end 
   if nomination.valid?
    render json: { nominations: Nomination.all, movies: Movie.all }
   else
    render json: { error: 'Nomination not created'}, status: 401
   end 
  end

  # PATCH/PUT /nominations/1
  # PATCH/PUT /nominations/1.json
  def update
    respond_to do |format|
      if @nomination.update(nomination_params)
        format.html { redirect_to @nomination, notice: 'Nomination was successfully updated.' }
        format.json { render :show, status: :ok, location: @nomination }
      else
        format.html { render :edit }
        format.json { render json: @nomination.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nominations/1
  # DELETE /nominations/1.json
  def destroy
    @nomination.destroy
    respond_to do |format|
      format.html { redirect_to nominations_url, notice: 'Nomination was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nomination
      @nomination = Nomination.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def nomination_params
      params.require(:nomination).permit(:user_id, :movie_id)
    end
end
