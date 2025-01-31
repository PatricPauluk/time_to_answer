namespace :dev do

  DEFAULT_PASSWORD = 123456

  desc "Configura o ambiente de desenvolvimento:" # Descrição
  task setup: :environment do # call: rails dev:setup
    if Rails.env.development?
      # Também poderia ser escrito da seguinte forma:
      # show_spinner("Apagando Banco de Dados...") do
      #   %x(rails db:drop)
      # end
      show_spinner("Apagando Banco de Dados...")            { %x(rails db:drop) }
      show_spinner("Criando Banco de Dados...")             { %x(rails db:create) } 
      show_spinner("Migrando Tabelas...")                   { %x(rails db:migrate) }
      show_spinner("Cadastrando o Administrador Padrão...") { %x(rails dev:add_default_admin) }
      show_spinner("Cadastrando o Usuário Padrão...")       { %x(rails dev:add_default_user) }
    else
      puts "Você não esta em ambiente de desenvolvimento."
    end
  end

  desc "Adiciona o administrador padrão"
  task add_default_admin: :environment do
    Admin.create!(
      email: 'admin@admin.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end

  desc "Adiciona o usuário padrão"
  task add_default_user: :environment do
    User.create!(
      email: 'user@user.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end

  # -----------------------------------------------------------------------------
  
  # Tudo abaixo de private é privado apenas este arquivo
  private
  # Função para efeito de spinner no terminal
  def show_spinner(msg_start, msg_end = "Feito!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}", format: :pulse_2)
    spinner.auto_spin # Automatic animation with default interval
    yield # Executa o comando especificado após chamar o show_spinner
    spinner.success("Feito!")
  end

end
