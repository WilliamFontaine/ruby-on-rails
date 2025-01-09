class SavsController < ApplicationController
  before_action :set_sav, only: [:show, :edit, :update, :destroy]
  before_action :set_client, only: [:new, :create]
  
  def index
    @savs = Sav.includes(:client).all
    
    # Filtres
    @savs = @savs.where('produit ILIKE ?', "%#{params[:produit]}%") if params[:produit].present?
    @savs = @savs.where(fournisseur: params[:fournisseur]) if params[:fournisseur].present?
    @clients = Client.select(:id, :prenom, :nom).order(:prenom, :nom) # Charge les clients avec ID pour le filtre
    # Appliquer des filtres si nécessaire
    if params[:client_nom_prenom].present?
      @savs = @savs.where(client_id: params[:client_nom_prenom]) # Filtrer par ID du client
    end
    
    
    # État des SAV
    @savs = @savs.sans_retour if params[:sans_retour] == "1"
    @savs = @savs.sans_enlevement if params[:sans_enlevement] == "1"
  end
  
  def show
  end
  
  def new
    @sav = @client.savs.build(date_depot: Date.today)
  end
  
  def create
    @sav = @client.savs.build(sav_params)
    
    if @sav.save
      redirect_to @sav, notice: 'SAV créé avec succès.'
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
  end
  
  def update
    if @sav.update(sav_params)
      redirect_to @sav, notice: 'SAV mis à jour avec succès.'
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @sav.destroy
    redirect_to savs_path, notice: 'SAV supprimé avec succès.'
  end
  
  def update_returned_today
    Sav.sans_retour.update_all(date_retour: Date.today)
    redirect_to savs_path, notice: 'Les SAV ont été mis à jour avec la date du jour.'
  end
  
  private
  
  def set_sav
    @sav = Sav.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to savs_path, alert: 'SAV non trouvé.'
  end
  
  def set_client
    @client = Client.find(params[:client_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to clients_path(show_all: true), alert: 'Client non trouvé.'
  end
  
  def sav_params
    params.require(:sav).permit(:produit, :fournisseur, :date_depot, :date_retour, :date_enlevement)
  end
end