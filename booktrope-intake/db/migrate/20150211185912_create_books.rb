class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.text :synopsis

      t.timestamps null: false
    end
    add_index :books, :title
  end
end
