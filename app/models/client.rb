class Client < ApplicationRecord
  has_many :savs, dependent: :destroy

  validates :nom, presence: { message: "Le nom est obligatoire" }
  validates :prenom, presence: { message: "Le prénom est obligatoire" }
  validates :telephone, presence: { message: "Le téléphone est obligatoire" },
                       format: { 
                         with: /\A(?:(?:\+|00)33[\s.-]{0,3}(?:\(0\)[\s.-]{0,3})?|0)[1-9](?:(?:[\s.-]?\d{2}){4}|\d{2}(?:[\s.-]?\d{3}){2})\z/,
                         message: "Le format du numéro de téléphone est invalide"
                       }
end