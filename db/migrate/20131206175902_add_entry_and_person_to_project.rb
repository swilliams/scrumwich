class AddEntryAndPersonToProject < ActiveRecord::Migration
  def change
    add_column :entries, :project_id, :integer

    create_table :people_projects, id: false do |t|
      t.references :person, null: false
      t.references :project, null: false
    end
  end
end
