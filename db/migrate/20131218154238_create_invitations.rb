class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :code
      t.references :project, index: true
      t.references :person, index: true

      t.timestamps
    end
  end
end
