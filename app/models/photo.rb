class Photo < ApplicationRecord

    mount_uploader :image, ImageUploader


    belongs_to :user,  inverse_of: :photos
    has_many :questions,  inverse_of: :photo

end
