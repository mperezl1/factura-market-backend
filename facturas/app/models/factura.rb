class Factura < ApplicationRecord
  # Validaciones de presencia y tipo
  validates :cliente_id, presence: true
  validates :total, presence: true, numericality: { greater_than: 0, message: "debe ser mayor a cero" }
  validates :fecha, presence: true
  validate  :fecha_valida?

  private

  # Validación de fecha de emisión
  def fecha_valida?
    errors.add(:fecha, "no es una fecha válida") if fecha.present? && !fecha.is_a?(Date)
  end
end
