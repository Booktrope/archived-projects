json.array!(@books) do |book|
  json.extract! book, :id, :title, :synopsis
  json.url book_url(book, format: :json)
end
