class Review < ApplicationRecord

  RATINGS = [1,2,3,4,5]

  belongs_to :movie

  validates :name, presence: true

  validates :comment, length: { minimum: 4 }

  validates :stars, inclusion: { in: RATINGS, message: "must be between 1 and 5" } 

  def stars_as_percent
    if stars
      (stars / 5.0) * 100.0
    else
      0.0
    end
  end
end
