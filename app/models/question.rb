class Question < ApplicationRecord
  # torna o assunto opcional a ser informado (não vamos utilizar nessa situação, mas fica como exemplo)
  # belongs_to :subject, optional: true 

  # torna o assunto obrigatorio a ser informado, reforça que subject_id tem muitas questions, evitando conflitos
  belongs_to :subject, inverse_of: :questions

  has_many :answers # uma pergunta tem muitas respostas

  # aceita respostas aninhadas, mas rejeita se todas estiverem em branco, permite apagar
  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true 

  # Kaminari
  paginates_per 5
end
