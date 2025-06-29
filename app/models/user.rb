class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :user_profile
  accepts_nested_attributes_for :user_profile, reject_if: :all_blank

  # Callback
  after_create :set_statistic # roda o evento sempre após criar o usuário


  # Validations
  validates :first_name, presence: true, length: { minimum: 3 }, on: :update, unless: :reset_password_token_present?
  
  # Virtual Attributes
  def full_name
    [self.first_name, self.last_name].join(' ')
  end

  private

  def set_statistic
     AdminStatistic.set_event(AdminStatistic::EVENTS[:total_users])
  end

  # Verifica se o token de redefinição de senha está presente
  # Isso é usado para evitar que a validação do nome seja aplicada quando o usuário está redefinindo a senha
  # durante o processo de recuperação de senha
  def reset_password_token_present?
    # Transforma o token em booleano, verificando se ele está presente
    !!$global_params[:user][:reset_password_token]
  end

end
