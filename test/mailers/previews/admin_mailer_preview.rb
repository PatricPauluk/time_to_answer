class AdminMailerPreview < ActionMailer::Preview
    # Preview do email de atualização de email
    # Acessar em http://localhost:3000/rails/mailers/
    # O preview é usado para visualizar o email antes de enviá-lo
    def update_email
        AdminMailer.update_email(Admin.first, Admin.last)
    end
end