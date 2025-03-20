namespace :dev do

  DEFAULT_PASSWORD = 111111
  # Caminho padrão para arquivos temporários
  # Rails.root pega  o caminho da raiz do sistema, e os outros vai seguindo as pastas
  # O caminho poderia ser escrito diretamente: lib/tasks/dev.rake ...
  # ... Porém, o File.join concatena os caminhos para nós, garantindo mais precisão
  DEFAULT_FILES_PATH = File.join(Rails.root, 'lib', 'tmp')

  # Task principal que "reseta" o banco de dados e cria o usuário e admin padrão do sistema
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
      # show_spinner("Cadastrando Administradores Extras...") { %x(rails dev:add_extras_admin) }
      show_spinner("Cadastrando o Usuário Padrão...")       { %x(rails dev:add_default_user) }
      show_spinner("Cadastrando Assuntos Padrão...")        { %x(rails dev:add_subjects) }
      show_spinner("Cadastrando Perguntas e Respostas...")  { %x(rails dev:add_answers_and_questions) }
    else
      puts "Você não esta em ambiente de desenvolvimento."
    end
  end

  desc "Adiciona o administrador padrão"
  task add_default_admin: :environment do # call: rails dev:add_default_admin
    Admin.create!(
      email: 'admin@admin.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end

  desc "Adiciona o usuário padrão"
  task add_default_user: :environment do # call: rails dev:add_default_user
    User.create!(
      email: 'user@user.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end

  # Task para criar 10 usuários aleatórios administradores no sistema
  desc "Adiciona o administradores extras" 
  task add_extras_admin: :environment do # call: rails dev:add_extras_admin
    10.times do |i|
      Admin.create!(
        email: Faker::Internet.email,
        password: DEFAULT_PASSWORD,
        password_confirmation: DEFAULT_PASSWORD
      )
    end
  end

  desc "Adiciona assuntos padrão"
  task add_subjects: :environment do # call: rails dev:add_subjects
    file_name = 'subjects.txt'
    file_path = File.join(DEFAULT_FILES_PATH, file_name)
    # Lê cada linha do arquivo e cria um assunto
    File.open(file_path, 'r').each do |line|
      Subject.create!(description: line.strip) # .strip retira os espaços em branco antes e depois da linha
    end
  end

  desc "Adicionar questões e respostas"
  task add_answers_and_questions: :environment do # call: rails dev:add_answers_and_questions
    Subject.all.each do |subject|
      rand(5..10).times do |i|
        Question.create!(
          description: "#{Faker::Lorem.paragraph} #{Faker::Lorem.question}", # Gera uma pergunta (o parágrafo é só pra aumentar o tamanho)
          subject: subject # Atribui o id do assunto ao questionário
        )
      end
    end
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