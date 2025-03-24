class Question < ApplicationRecord
  belongs_to :subject # uma pergunta pertence a um assunto
  has_many :answers # uma pergunta tem muitas respostas
  
  accepts_nested_attributes_for :answers # aceita respostas aninhadas
end
