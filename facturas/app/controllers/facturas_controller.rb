class FacturasController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  # POST /facturas
  def create
    @factura = Factura.new(factura_params)

    # --- Validar que el cliente exista en el microservicio de clientes ---
    begin
      # IMPORTANTE: dentro del contenedor Docker, el host es 'clientes' y el puerto interno 3000
      cliente_resp = Faraday.get("http://clientes:3000/clientes/#{@factura.cliente_id}")

    rescue Faraday::ConnectionFailed
      render json: { error: "Servicio de Clientes no disponible" }, status: :service_unavailable
      return
    end

    # --- Guardar factura ---
    if @factura.save
      render json: @factura, status: :created, location: factura_url(@factura)
    else
      render json: { errors: @factura.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # GET /facturas/:id
  def show
    @factura = Factura.find(params[:id])
    render json: @factura, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Factura no encontrada" }, status: :not_found
  end

  # GET /facturas?fechaInicio=yyyy-mm-dd&fechaFin=yyyy-mm-dd
  def index
    inicio = params[:fechaInicio].present? ? Date.parse(params[:fechaInicio]) : Date.today.beginning_of_month
    fin    = params[:fechaFin].present? ? Date.parse(params[:fechaFin]) : Date.today.end_of_month

    @facturas = Factura.where(fecha: inicio..fin)
    render json: @facturas, status: :ok
  rescue ArgumentError
    render json: { error: "Formato de fecha inválido" }, status: :unprocessable_entity
  end

  private

  def factura_params
    params.require(:factura).permit(:cliente_id, :total, :fecha)
  end
end
