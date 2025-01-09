class CreateSavs < ActiveRecord::Migration[8.0]
  def change
    create_table :savs do |t|
      t.string :produit
      t.string :fournisseur
      t.date :date_depot
      t.date :date_retour
      t.date :date_enlevement
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
