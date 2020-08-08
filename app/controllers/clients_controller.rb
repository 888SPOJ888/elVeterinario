class ClientsController < ApplicationController
  # GET /clients
  # GET /clients.json
  def index
    @clients = Client.all
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
    @client = Client.find params[:id]
  end

  # GET /clients/new
  def new
    @client = Client.new
    @client.pets.build
    # Esto crea una nueva instancia de Cliente y 1 instancia de Mascota que pertenecen al Cliente.
  end

  # GET /clients/1/edit
  def edit
    @client = Client.find params[:id]
  end

  # POST /clients
  # POST /clients.json
  def create
    @client = Client.new(client_params)
    if @client.save
     redirect_to client_path(@client)
    else
     render ‘new’
    end
  end

  # PATCH/PUT /clients/1
  # PATCH/PUT /clients/1.json
  def update
    @client = Client.find params[:id]
    respond_to do |format|
      if @client.update_attributes(client_params)
        format.html { redirect_to client_path(@client), notice: 'Cliente fue Actualizado correctamente.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client = Client.find params[:id]
    @client.destroy
    respond_to do |format|
      format.html { redirect_to clients_url, notice: 'Cliente fue Eliminado correctamente.' }
    end
  end

  private
    def client_params
      # Esto permite que los atributos de apartment sean guardados.
      # El parametró destroy  nos permite eliminar un apartment cuando se enviar el formulario.
      params.require(:client).permit(:name, :phone, :email, pets_attributes: [:id, :name, :race, :birthdate, :client_id, :_destroy])
    end
end
