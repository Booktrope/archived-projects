class AddRoleToSigners < ActiveRecord::Migration
  def change
    add_column :signers, :role, :string
  end
end
