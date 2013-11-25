class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :yesterday, null: false
      t.string :today, null: false
      t.string :block
      t.references :person, null: false

      t.timestamps
    end
  end
end
