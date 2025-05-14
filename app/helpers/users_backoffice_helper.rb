module UsersBackofficeHelper

    # Verifica se o avatar existe em user_profile (assumindo que user_profile já existe)
    def avatar_url
        if current_user.user_profile.avatar.attached?
            current_user.user_profile.avatar
        else
            'profile-icon.png'
        end
    end

end
