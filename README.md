# README

[![Rails 7.1.x](https://img.shields.io/badge/Rails-5.2.8.1-brightgreen.svg)](https://rubyonrails.org/)
[![Ruby 3.2.x](https://img.shields.io/badge/Ruby-2.7.8-blue.svg)](https://www.ruby-lang.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**PROJETO EM CONSTRUÇÃO**

Este README documenta os passos necessários para configurar e executar a aplicação time_to_answer.

## 1. Pré-requisitos

Antes de começar, certifique-se de que as seguintes ferramentas estejam instaladas em sua máquina:

* **Ruby:** Recomenda-se a versão `2.7.8`. Você pode verificar sua versão com o comando:

  ```bash
  ruby -v

* **Rails:** Recomenda-se a versão `5.2.8.1`. Você pode verificar sua versão com o comando:

  ```bash
  rails -v

## 2. Configuração do Ruby v2.7.8

Siga estes passos para instalar o `rbenv` e o Ruby 2.7.8:

**a) Instalar dependências do rbenv:**

```bash
apt-get update
apt-get install -y git ruby-dev build-essential libssl-dev libreadline-dev zlib1g-dev
```

**b) Instalar o rbenv:**

```bash
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init - bash)"' >> ~/.bashrc
source ~/.bashrc
```

**c) Instalar o plugin `ruby-build`:**

```bash
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
```

Antes de instalar o Ruby, precisamos instalar as dependências curl e wget:

```bash
apt-get update
apt-get install -y curl wget
```

**d) Instalar o Ruby 2.7.8 com rbenv:**

```bash
rbenv install 2.7.8
```

**e) Definir o Ruby 2.7.8 como a versão global:**

```bash
rbenv global 2.7.8
```

**f) Verificar a instalação:**

```bash
ruby -v
```

## 3. Configuração do Rails v5.2.8.1

**a) O Rails vai exigir as seguintes dependências, instale-as previamente para evitar erros:**

```bash
gem install nokogiri -v 1.15.7
gem install net-imap -v 0.4.17
gem update —system 3.3.22
```

**b) Agora, instalamos o Rails:**

```bash
gem install rails -v 5.2.8.1
```

## 4. Instalando o Yarn e o Bundler

**a) Execute os comandos para a instalação do Yarn:**

```bash
apt update
apt install --yes nodejs npm  # Yarn depende do Node.js e npm
npm install --global yarn
```

No meu caso, o Yarn funcionou tranquilamente na versão 1.22.22.

**b) Instale o Bundler na vesão 2.4.22:**

```bash
gem install bundler -v 2.4.22
```

## 5. Baixando o Projeto e Finalizando as Configurações


**a) Baixar o projeto time_to_answer na sua máquina:**

```bash
git clone https://github.com/PatricPauluk/time_to_answer.git
```

**b) Navegar até a pasta do projeto:**


```bash
cd time_to_answer/
```

**c) Execute os comandos a seguir para baixar as dependências e realizar as configurações do banco:**

```bash
bundle
yarn
rails db:migrate
rails dev:setup
```

Rode o servidor, e acesse a porta [localhost:3000](http://localhost:3000) para confirmar se deu tudo certo.

```bash
rails s
```

**Login com usuário Administrador:**

Login: admin@admin.com | Senha: 111111
