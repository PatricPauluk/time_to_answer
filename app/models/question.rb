class Question < ApplicationRecord
  # torna o assunto opcional a ser informado (não vamos utilizar nessa situação, mas fica como exemplo)
  # belongs_to :subject, optional: true 
  
  # torna o assunto obrigatorio a ser informado, informa que tera uma contagem obrigatória do assunto (deve ser criada no banco), ...
  #... reforça que subject_id tem muitas questions, evitando conflitos
  belongs_to :subject, counter_cache: true, inverse_of: :questions

  # uma pergunta tem muitas respostas
  has_many :answers 

  # aceita respostas aninhadas, mas rejeita se todas estiverem em branco, permite apagar
  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true 

  # Callback
  after_create :set_statistic

  # Kaminari
  paginates_per 5

  # Obs: métodos de classe contém self.
  # Os que não contém, são métodos de instância

  # Exemplo SQL:
  # SELECT  "questions".* FROM "questions" WHERE (lower(description) LIKE '%voluptatum%')
  scope :_search_, -> (page, term) {
    Question.includes(:answers, :subject).where("lower(description) LIKE ?", "%#{term.downcase}%").page(page)
  }

  scope :_search_subject_, -> (page, subject_id) {
    includes(:answers, :subject).where(subject_id: subject_id).page(page)
  }

  # Exemplo SQL:
  # SELECT  "questions".* FROM "questions" ORDER BY created_at desc
  scope :last_questions, -> (page) {
    Question.includes(:answers, :subject).order('created_at desc').page(page)
  }

  private
  
  def set_statistic
     AdminStatistic.set_event(AdminStatistic::EVENTS[:total_questions])
  end

end
