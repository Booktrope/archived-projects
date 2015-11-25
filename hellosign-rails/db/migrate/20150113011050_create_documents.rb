class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :name
      t.string :hellosign_id
      t.hstore :details
      t.timestamps
    end
  end
end
