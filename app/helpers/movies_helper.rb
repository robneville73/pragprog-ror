module MoviesHelper
    def total_gross(movie)
        if movie.flop?
            "Flop!"
        else
            number_to_currency(movie.total_gross, precision: 0)
        end
    end

    def year_of(movie)
        movie.released_on.year
    end

    def nav_link_to(label, url)
        if current_page?(url)
            link_to(label, url, class: "active")
        else
            link_to(label, url)
        end
    end
end