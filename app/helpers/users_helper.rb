module UsersHelper

    def profile_image(user, size=80)
        image_tag("https://secure.gravatar.com/avatar/#{user.gravatar_id}?s=#{size}", alt: user.name)
    end

end
