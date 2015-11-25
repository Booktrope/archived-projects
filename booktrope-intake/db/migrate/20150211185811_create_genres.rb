class CreateGenres < ActiveRecord::Migration
  def change
    create_table :genres do |t|
      t.string :name

      t.timestamps null: false
    end
    add_index :genres, :name
  end
end
