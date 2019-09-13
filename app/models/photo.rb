class Photo < ApplicationRecord
    belongs_to :user,  inverse_of: :photos
    has_many :questions,  inverse_of: :photo
end
