class Subject < ApplicationRecord
    has_many :questions # um assunto tem muitas perguntas
    # Inserindo o comando acima, consigo validar alguns testes no rails console
    # Exemplo: Subject.find(1).questions
    # Exemplo: Subject.find(1).questions[0].description
end
