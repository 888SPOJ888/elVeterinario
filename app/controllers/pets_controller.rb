class PetsController < ApplicationController
  #before_action :set_pet, only: [:show, :edit, :update, :destroy]
  before_action :find_client

  # GET /pets
  # GET /pets.json
  def index
    @pets = @client.pets# Se muestran las macotas asociados a este cliente
  end

  # GET /pets/1
  # GET /pets/1.json
  def show
    @pet = Pet.find(params[:id])   
  end

  # GET /pets/new
  def new
    @pet = Pet.new    
  end

  # GET /pets/1/edit
  def edit
    @pet = Pet.find(params[:id])   
  end

  # POST /pets
  # POST /pets.json
  def create
    @pet = Pet.new(pet_params)#Strong parameters, previene ataques de mass assignment
    @pet.client = @client #Asignamos el cliente, ya no es necesario pasarlo en el formulario, ahora viene en la url
    respond_to do |format|
      if @pet.save
        format.html { redirect_to client_pet_path(@client, @pet), notice: 'Mascota fue Creada correctamente.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /pets/1
  # PATCH/PUT /pets/1.json
  def update
    @pet = Pet.find params[:id]
    respond_to do |format|
      if @pet.update(pet_params.merge(client: @client))# Se añade el client que se obtuvo en la llamada a find_client
        format.html { redirect_to client_pet_path(@client, @pet), notice: 'Macota Actualizada correctamente.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /pets/1
  # DELETE /pets/1.json
  def destroy
    @pet = Pet.find params[:id]
    @pet.destroy
    respond_to do |format|
      format.html { redirect_to client_pets_url, notice: 'Mascota Eliminada correctamente.' }
    end
  end

  private
    #def pet_params
    #  params.require(:pet).permit(:name, :race, :birthdate, :client_id)
    #end

    def pet_params
      params.require(:pet).permit(:name, :race, :birthdate, pet_histories_attributes: [:id, :weight, :heigth, :description, :pet_id, :_destroy])
    end

    def find_client
      @client = Client.find params[:client_id]
    end

end
