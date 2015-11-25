require 'test_helper'

class BookGenresControllerTest < ActionController::TestCase
  setup do
    @book_genre = book_genres(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:book_genres)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create book_genre" do
    assert_difference('BookGenre.count') do
      post :create, book_genre: { Book_id: @book_genre.Book_id, Genre_id: @book_genre.Genre_id }
    end

    assert_redirected_to book_genre_path(assigns(:book_genre))
  end

  test "should show book_genre" do
    get :show, id: @book_genre
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @book_genre
    assert_response :success
  end

  test "should update book_genre" do
    patch :update, id: @book_genre, book_genre: { Book_id: @book_genre.Book_id, Genre_id: @book_genre.Genre_id }
    assert_redirected_to book_genre_path(assigns(:book_genre))
  end

  test "should destroy book_genre" do
    assert_difference('BookGenre.count', -1) do
      delete :destroy, id: @book_genre
    end

    assert_redirected_to book_genres_path
  end
end
