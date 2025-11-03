# Define la estructura de datos y validaciones para la tabla 'clientes'
class Cliente < ApplicationRecord
  # Valida que los campos obligatorios estén presentes y sean únicos
  validates :nombre_o_razon_social, presence: true
  validates :identificacion, presence: true, uniqueness: true
  validates :correo, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :direccion, presence: true
end
