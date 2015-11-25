class BookGenresController < ApplicationController
  before_action :set_book_genre, only: [:show, :edit, :update, :destroy]

  # GET /book_genres
  # GET /book_genres.json
  def index
    @book_genres = BookGenre.all
  end

  # GET /book_genres/1
  # GET /book_genres/1.json
  def show
  end

  # GET /book_genres/new
  def new
    @book_genre = BookGenre.new
  end

  # GET /book_genres/1/edit
  def edit
  end

  # POST /book_genres
  # POST /book_genres.json
  def create
    @book_genre = BookGenre.new(book_genre_params)

    respond_to do |format|
      if @book_genre.save
        format.html { redirect_to @book_genre, notice: 'Book genre was successfully created.' }
        format.json { render :show, status: :created, location: @book_genre }
      else
        format.html { render :new }
        format.json { render json: @book_genre.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /book_genres/1
  # PATCH/PUT /book_genres/1.json
  def update
    respond_to do |format|
      if @book_genre.update(book_genre_params)
        format.html { redirect_to @book_genre, notice: 'Book genre was successfully updated.' }
        format.json { render :show, status: :ok, location: @book_genre }
      else
        format.html { render :edit }
        format.json { render json: @book_genre.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /book_genres/1
  # DELETE /book_genres/1.json
  def destroy
    @book_genre.destroy
    respond_to do |format|
      format.html { redirect_to book_genres_url, notice: 'Book genre was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book_genre
      @book_genre = BookGenre.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_genre_params
      params.require(:book_genre).permit(:Book_id, :Genre_id)
    end
end
