class Book < ActiveRecord::Base
	has_many :book_genres, dependent: :destroy
	has_many :genres, through: :book_genres, source: :genre
	
	has_attached_file :manuscript
	validates_attachment :manuscript,
		content_type: { content_type: ['application/pdf'] }
end
