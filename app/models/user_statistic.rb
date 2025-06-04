class UserStatistic < ApplicationRecord
  belongs_to :user

  # Virtual Attributes
  def total_questions
    self.right_questions + self.wrong_questions
  end

  # Métodos de classe
  # Caso o usuário estiver logado, incrementa o campo de respostas corretas ou erradas
  def self.set_statistic(answer, current_user)
      if !!current_user # É o mesmo que user_signed_in
          user_statistic = UserStatistic.find_or_create_by(user: current_user)
          answer.correct? ? user_statistic.right_questions += 1 : user_statistic.wrong_questions += 1
          user_statistic.save
      end
  end

end
