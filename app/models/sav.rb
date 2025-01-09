class Sav < ApplicationRecord
  FOURNISSEURS = ['Bosch', 'Makita', 'Delko'].freeze
  
  belongs_to :client
  
  validates :produit, presence: { message: "Le nom du produit est obligatoire" }
  validates :fournisseur, presence: { message: "Le fournisseur est obligatoire" }, 
                         inclusion: { in: FOURNISSEURS, message: "n'est pas un fournisseur valide" }
  validates :date_depot, presence: { message: "La date de dépôt est obligatoire" }
  
  scope :en_cours, -> { where(date_enlevement: nil) }
  scope :sans_retour, -> { where(date_retour: nil) }
  scope :sans_enlevement, -> { where(date_enlevement: nil) }

  after_initialize :set_default_date_depot, if: :new_record?

  private

  def set_default_date_depot
    self.date_depot ||= Date.today
  end
end