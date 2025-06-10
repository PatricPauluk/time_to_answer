class AdminStatistic < ApplicationRecord
    EVENTS = {
        total_users: "TOTAL_USERS",
        total_questions: "TOTAL_QUESTIONS"
    }

    # Scopes
    scope :total_users, -> {
        find_by_event(EVENTS[:total_users]).value
    }

    scope :total_questions, -> {
        find_by_event(EVENTS[:total_questions]).value    
    }

    # Class Methods
    # Evento chamado em: app/models/user.rb e app/models/question.rb
    def self.set_event(event)
        admin_statistic = AdminStatistic.find_or_create_by(event: event) # event é o mesmo que: EVENTS[:total_users] ou EVENTS[:total_questions]
        admin_statistic.value += 1
        admin_statistic.save # salva ao somar mais um usuário no total de usuários
    end

end
