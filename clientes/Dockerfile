# clientes/Dockerfile
# Imagen base de Ruby para Rails
FROM ruby:3.2.2

# Instalar dependencias necesarias (ej. para sqlite3 y Node/Yarn para assets de Rails)
RUN apt-get update -qq && apt-get install -y nodejs npm build-essential libpq-dev sqlite3 libsqlite3-dev

# Establecer el directorio de trabajo
WORKDIR /app

# Copiar el Gemfile e instalar las gemas
COPY Gemfile Gemfile.lock /app/
RUN bundle install

# Copiar el código de la aplicación
COPY . /app

# Exponer el puerto de Rails
EXPOSE 3000

# Comando para iniciar el servidor Rails
# Esto puede variar si usas Puma, etc., ajusta el puerto si es necesario.
CMD ["rails", "server", "-b", "0.0.0.0"]