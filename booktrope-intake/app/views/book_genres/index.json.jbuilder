json.array!(@book_genres) do |book_genre|
  json.extract! book_genre, :id, :Book_id, :Genre_id
  json.url book_genre_url(book_genre, format: :json)
end
