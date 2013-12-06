class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name, limit: 40
      t.references :owner, index: true, null: false
      t.references :entries, index: true

      t.timestamps
    end
  end
end
