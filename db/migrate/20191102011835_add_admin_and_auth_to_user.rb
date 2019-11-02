class AddAdminAndAuthToUser < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean
    add_column :users, :auth_user, :boolean
  end
end
