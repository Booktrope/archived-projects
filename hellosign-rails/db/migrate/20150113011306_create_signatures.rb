class CreateSignatures < ActiveRecord::Migration
  def change
    create_table :signatures do |t|
      t.belongs_to :document
      t.belongs_to :signer
      t.timestamps
    end
  end
end
