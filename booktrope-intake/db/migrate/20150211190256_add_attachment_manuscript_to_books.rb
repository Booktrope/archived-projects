class AddAttachmentManuscriptToBooks < ActiveRecord::Migration
  def self.up
    change_table :books do |t|
      t.attachment :manuscript
    end
  end

  def self.down
    remove_attachment :books, :manuscript
  end
end
