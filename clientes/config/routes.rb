Rails.application.routes.draw do
  # Define todas las rutas RESTful para el recurso 'clientes'
  # (GET /clientes, POST /clientes, GET /clientes/new, etc.)
  resources :clientes

  # Establece la ruta raíz para que el navegador vaya al listado de clientes por defecto
  root "clientes#index"

  # Ruta de estado de salud (Rails default)
  get "up" => "rails/health#show", as: :rails_health_check
end
