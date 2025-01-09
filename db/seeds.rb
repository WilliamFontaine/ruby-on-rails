# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Sav.destroy_all
Client.destroy_all

puts "Création de clients et SAV..."

clients = 10.times.map do
  Client.create!(
    nom: Faker::Name.last_name,
    prenom: Faker::Name.first_name,
    adresse: Faker::Address.full_address,
    telephone: "0#{Faker::Number.number(digits: 9)}"  )
end

clients.each do |client|
  rand(0..20).times do
    produit = Faker::Commerce.product_name
    fournisseur = Sav::FOURNISSEURS.sample
    date_depot = Faker::Date.backward(days: 365)
    date_retour = [nil, Faker::Date.between(from: date_depot, to: Date.today)].sample
    date_enlevement = date_retour.nil? ? nil : [nil, Faker::Date.between(from: date_retour, to: Date.today)].sample

    Sav.create!(
      produit: produit,
      fournisseur: fournisseur,
      date_depot: date_depot,
      date_retour: date_retour,
      date_enlevement: date_enlevement,
      client: client
    )
  end
end

puts "Seeding terminé avec succès !"