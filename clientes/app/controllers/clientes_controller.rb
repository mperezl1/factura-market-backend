class ClientesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  # POST /clientes
  def create
    @cliente = Cliente.new(cliente_params)

    if @cliente.save
      # 201 Created: El cliente fue creado exitosamente
      render json: @cliente, status: :created, location: cliente_url(@cliente)
    else
      # 422 Unprocessable Entity: Error en la validación de datos
      render json: @cliente.errors, status: :unprocessable_entity
    end
  end

  # GET /clientes/:id
  def show
    @cliente = Cliente.find(params[:id])
    render json: @cliente, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Cliente no encontrado" }, status: :not_found
  end

  # GET /clientes
  def index
    @clientes = Cliente.all
    render json: @clientes, status: :ok
  end

  private

  # Parámetros fuertes para asegurar que solo se permitan los campos correctos
  def cliente_params
    params.require(:cliente).permit(:nombre_o_razon_social, :identificacion, :correo, :direccion)
  end
end
