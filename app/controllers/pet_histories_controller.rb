class PetHistoriesController < ApplicationController
  #before_action :set_pet_history, only: [:show, :edit, :update, :destroy]
  before_action :find_pet
  before_action :find_client
  # GET /pet_histories
  # GET /pet_histories.json
  def index
    @pet_histories = @pet.pet_histories# Se muestran los historiales asociados a este mascota
  end

  # GET /pet_histories/1
  # GET /pet_histories/1.json
  def show
    @pet_history = PetHistory.find(params[:id])
  end

  # GET /pet_histories/new
  def new
    @pet_history = PetHistory.new
  end

  # GET /pet_histories/1/edit
  def edit
    @pet_history = PetHistory.find(params[:id])
  end

  # POST /pet_histories
  # POST /pet_histories.json
  def create
    @pet_history = PetHistory.new(pet_history_params)#Strong parameters, previene ataques de mass assignment
    @pet_history.pet = @pet #Asignamos la mascota, ya no es necesario pasarlo en el formulario, ahora viene en la url
    respond_to do |format|
      if @pet_history.save
        format.html { redirect_to client_pet_pet_history_path(@client, @pet, @pet_history), notice: 'Se creo Consulta Correctamente.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /pet_histories/1
  # PATCH/PUT /pet_histories/1.json
  def update
    @pet_history = PetHistory.find params[:id]
    respond_to do |format|
      if @pet_history.update(pet_history_params.merge(pet: @pet))# Se añade la mascota que se obtuvo en la llamada a find_pet
        format.html { redirect_to client_pet_pet_histories_path(@client,@pet, @pet_history), notice: 'Consulta Editada Correctamente.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /pet_histories/1
  # DELETE /pet_histories/1.json
  def destroy
    @pet_history = PetHistory.find params[:id]
    @pet_history.destroy
    respond_to do |format|
      format.html { redirect_to client_pet_pet_histories_url, notice: 'Consulta eliminada correctamente.' }
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def pet_history_params
      params.require(:pet_history).permit(:weight, :heigth, :description, :pet_id)
    end
  
    def find_pet
      @pet = Pet.find params[:pet_id]
    end

    def find_client
      @client = Client.find params[:client_id]
    end
end
