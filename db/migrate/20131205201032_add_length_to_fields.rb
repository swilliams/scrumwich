class AddLengthToFields < ActiveRecord::Migration
  def change
    change_column :entries, :yesterday, :string, limit: 560
    change_column :entries, :today, :string, limit: 560
    change_column :entries, :block, :string, limit: 560
    change_column :people, :name, :string, limit: 560
    change_column :people, :email, :string, limit: 560
  end
end
