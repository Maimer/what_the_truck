class ChangeRoleToAdminInUsers < ActiveRecord::Migration
  def change
    remove_column :users, :role
    add_column :users, :admin, :boolean, null: false, default: false
  end
end
