# Escolha uma imagem base com Ruby e Bundler pré-instalados
FROM ruby:2.7.8-slim-buster

# Instale dependências de nível de sistema operacional que podem ser necessárias
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    nodejs \
    yarn

# Defina o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copie o Gemfile e o Gemfile.lock para o contêiner
COPY Gemfile Gemfile.lock ./

# Instale as dependências do Ruby (excluindo development e test)
RUN bundle install --without development test

# Copie o restante dos arquivos do seu projeto para o contêiner
COPY . .

# Pré-compile os assets
RUN rails assets:precompile

# Define a variável de ambiente para produção
ENV RAILS_ENV=production
# É fundamental definir uma SECRET_KEY_BASE em produção.
# Você pode passar isso como um argumento de build ou variável de ambiente.
# Exemplo (melhor passar como variável de ambiente ao executar):
# ENV SECRET_KEY_BASE=algumasecretkey

# Exponha a porta que o servidor Rails usa (padrão: 3000)
EXPOSE 3000

# Comando para iniciar o servidor Rails (Puma, conforme seu Gemfile)
CMD ["bundle", "exec", "puma", "-b", "tcp://0.0.0.0:3000", "-e", "production"]