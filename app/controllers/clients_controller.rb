class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]
  
  def index
    @show_all = params[:show_all] == 'true'
    @clients = if @show_all
      Client.all
    else
      Client.joins(:savs).where(savs: { date_enlevement: nil }).distinct
    end
  end
  
  def show
  end
  
  def new
    @client = Client.new
  end
  
  def edit
  end
  
  def create
    @client = Client.new(client_params)
    
    if @client.save
      redirect_to @client, notice: 'Client créé avec succès.'
    else
      flash.now[:alert] = "Erreur lors de la création du client"
      render :new, status: :unprocessable_entity
    end
  end
  
  def update
    if @client.update(client_params)
      redirect_to @client, notice: 'Client mis à jour avec succès.'
    else
      flash.now[:alert] = "Erreur lors de la mise à jour du client"
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @client.destroy
    redirect_to clients_path(show_all: true), notice: 'Client supprimé avec succès.'
  end
  
  def export_csv
    @show_all = params[:show_all] == 'true'
    @clients = @show_all ? Client.all : Client.joins(:savs).where(savs: { date_enlevement: nil }).distinct
    
    respond_to do |format|
      format.csv { send_data generate_csv(@clients), filename: "clients-#{Date.today}.csv" }
    end
  end

  def export_json
    @clients = @show_all ? Client.all : Client.joins(:savs).where(savs: { date_enlevement: nil }).distinct
    
    respond_to do |format|
      format.json { send_data @clients.to_json(include: { savs: { only: [:produit, :fournisseur, :date_depot, :date_retour, :date_enlevement] } }), filename: "clients-#{Date.today}.json" }
    end
  end
  
  private
  
  def set_client
    @client = Client.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to clients_path(show_all: true), alert: 'Client non trouvé.'
  end
  
  def client_params
    params.require(:client).permit(:nom, :prenom, :adresse, :telephone)
  end
  
  def generate_csv(clients)
    CSV.generate(headers: true) do |csv|
      csv << ["Nom", "Prénom", "Téléphone", "Produit SAV", "Fournisseur", "Date de Dépôt", "Date de Retour", "Date d'Enlèvement"]
      
      clients.each do |client|
        client.savs.each do |sav|
          csv << [client.nom, client.prenom, client.telephone, sav.produit, sav.fournisseur, sav.date_depot, sav.date_retour, sav.date_enlevement]
        end
      end
    end
  end
end
