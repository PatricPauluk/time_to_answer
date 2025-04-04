class Site::SearchController < SiteController
    def questions
        # SELECT  "questions".* FROM "questions" WHERE (lower(description) LIKE '%voluptatum%')
        # LIMIT ? OFFSET ?  [["LIMIT", 5], ["OFFSET", 5]]
        @questions = Question.includes(:answers).where("lower(description) LIKE ?",
                                                       "%#{params[:term].downcase}%")
                                                       .page(params[:page])
    end
end
