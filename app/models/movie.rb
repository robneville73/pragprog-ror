class Movie < ApplicationRecord

    RATINGS = %w(G PG PG-13 R NC-17)
    HIT_MINIMUM = 300_000_000
    FLOP_MAXIMUM = 225_000_000

    has_many :reviews, -> { order(created_at: :desc) }, dependent: :destroy
    has_many :favorites, dependent: :destroy
    has_many :fans, through: :favorites, source: :user
    has_many :critics, through: :reviews, source: :user
    has_many :characterizations, dependent: :destroy
    has_many :genres, through: :characterizations

    validates :title, :released_on, :duration, presence: true

    validates :description, length: { minimum: 25 }

    validates :total_gross, numericality: { greater_than_or_equal_to: 0 }

    validates :image_file_name, format: {
        with: /\w+\.(jpg|png)\z/i,
        message: "must be a JPG or PNG image"
    }

    validates :rating, inclusion: { in: RATINGS }

    scope :released, -> { where("released_on < ?", Time.now).order("released_on desc") }
    scope :upcoming, -> { where("released_on > ?", Time.now).order("released_on asc") }
    scope :hits, -> (minimum=HIT_MINIMUM) { released.where("total_gross > ?", minimum).order("total_gross desc") }
    scope :flops, -> (maximum=FLOP_MAXIMUM) { released.where("total_gross < ?", 225_000_000).order("total_gross") }
    scope :recent, -> (limit=3) { released.order("created_at desc").limit(limit) }
    scope :grossed_less_than, -> (gross=HIT_MINIMUM) { released.where("total_gross < ?", gross) }
    scope :grossed_more_than, -> (gross=HIT_MINIMUM) { released.where("total_gross > ?", gross) }

    def flop?
        total_gross.blank? || total_gross < FLOP_MAXIMUM
    end

    def average_stars
       reviews.average(:stars) || 0.0
    end

    def average_stars_as_percent
        (average_stars / 5.0) * 100.0
    end

end
