module UsersHelper

    def profile_image(user)
        image_tag("https://secure.gravatar.com/avatar/#{user.gravatar_id}", alt: user.name)
    end

end
