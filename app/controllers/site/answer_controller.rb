class Site::AnswerController < SiteController
    def question
        @answer = Answer.find(params[:answer_id])

        # O método foi passado para o helper, e para funcionar precisa de informações como o usuário atual e se ele esta logado
        UserStatistic.set_statistic(@answer, current_user)
    end


end
