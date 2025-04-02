class Answer < ApplicationRecord
  belongs_to :question, inverse_of: :answers
end
