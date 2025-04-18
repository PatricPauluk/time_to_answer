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
      # Cria 5 a 10 perguntas para cada assunto
      rand(5..10).times do |i|
        params = create_question_params(subject) # Cria os parâmetros para criar uma pergunta
        answers_array = params[:question][:answers_attributes] # Array de respostas
        add_answers(answers_array) # Cria as respostas
        elect_true_answer(answers_array) # Eleciona a resposta correta
        Question.create!(params[:question]) # Cria a pergunta
      end
    end
  end

  desc "Reseta contador dos assuntos"
  task reset_subject_counter: :environment do # call: rails dev:reset_subject_counter
    show_spinner("Resetando contador dos assuntos...") do
      Subject.all.each do |subject|
        Subject.reset_counters(subject.id, :questions)
      end
    end
  end
  
  # Tudo abaixo de private é privado apenas este arquivo -----------------------------------------------------------------------------
  private

  # Cria os parâmetros para criar uma pergunta
  # Subject.all.sample caso não seja passado um assunto como parâmetro, ele pega um aleatório
  def create_question_params(subject = Subject.all.sample)
    { question: {
          description: "#{Faker::Lorem.paragraph} #{Faker::Lorem.question}", # Gera uma pergunta (o parágrafo é só pra aumentar o tamanho)
          subject: subject, # Atribui o id do assunto ao questionário
          answers_attributes: [] # Cria uma lista vazia de respostas para ser preenchida posteriormente
      }
    }
  end

  # Cria 2 a 5 respostas erradas para uma pergunta
  def add_answers(answers_array = [])
    rand(2..5).times do |j|
      answers_array.push(create_answer_params) 
    end
  end

  # Cria os parâmetros para criar uma resposta correta ou errada
  def create_answer_params(correct = false)
    { description: Faker::Lorem.sentence, correct: correct }
  end
  
  # Eleciona a resposta correta
  def elect_true_answer(answers_array = [])
    selected_index = rand(answers_array.size) # Gera um número aleatório entre 0 e o tamanho do array de respostas (no caso, a quantidade de respostas geradas)
    answers_array[selected_index] = create_answer_params(true) # Substitui a resposta correta pelo index gerado
  end

  # Função para efeito de spinner no terminal
  def show_spinner(msg_start, msg_end = "Feito!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}", format: :pulse_2)
    spinner.auto_spin # Automatic animation with default interval
    yield # Executa o comando especificado após chamar o show_spinner
    spinner.success("Feito!")
  end

end