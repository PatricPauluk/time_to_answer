class Admin < ApplicationRecord
  # Aqui são especificados os modulos do devise.
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  

  # Kaminari (outra forma de paginar)
  # paginates_per 10
end