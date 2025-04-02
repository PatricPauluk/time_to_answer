class Site::WelcomeController < SiteController
  def index
    @questions = Question.includes(:answers).order(:description).page(params[:page])
  end
end
