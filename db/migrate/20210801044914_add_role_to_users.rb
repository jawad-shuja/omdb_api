class AddRoleToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :role, :integer, limit: 1, default: 2
  end
end
