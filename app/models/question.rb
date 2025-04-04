class Question < ApplicationRecord
  # torna o assunto opcional a ser informado (não vamos utilizar nessa situação, mas fica como exemplo)
  # belongs_to :subject, optional: true 
  
  # torna o assunto obrigatorio a ser informado, reforça que subject_id tem muitas questions, evitando conflitos
  belongs_to :subject, inverse_of: :questions

  # uma pergunta tem muitas respostas
  has_many :answers 

  # aceita respostas aninhadas, mas rejeita se todas estiverem em branco, permite apagar
  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true 

  # Kaminari
  paginates_per 5

  # Obs: métodos de classe contém self.
  # Os que não contém, são métodos de instância

  # Exemplo SQL:
  # SELECT  "questions".* FROM "questions" WHERE (lower(description) LIKE '%voluptatum%')
  scope :_search_, -> (page, term) {
    Question.includes(:answers).where("lower(description) LIKE ?", "%#{term.downcase}%").page(page)
  }

  # Exemplo SQL:
  # SELECT  "questions".* FROM "questions" ORDER BY created_at desc
  scope :last_questions, -> (page) {
    Question.includes(:answers).order('created_at desc').page(page)
  }

end
