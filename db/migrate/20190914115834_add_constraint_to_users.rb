class AddConstraintToUsers < ActiveRecord::Migration[5.1]
  def change
    change_column_null :users, :name, false
    change_column_null :users, :surname, false
    change_column :users, :roles_mask, :integer, :default=>0
  end
end
