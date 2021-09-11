module FavoritesHelper

    def favorite_button(movie, user)
        if user
            unless user_already_faved?(movie, user)
                button_to "♥️ Fave", movie_favorites_path(movie, user)
            else
                button_to "♡ Unfave", movie_favorite_path(movie, user), 
                                                             method: :delete
            end
        end
    end

end
