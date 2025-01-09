class CreateClients < ActiveRecord::Migration[8.0]
  def change
    create_table :clients do |t|
      t.string :nom
      t.string :prenom
      t.text :adresse
      t.string :telephone

      t.timestamps
    end
  end
end
