class Question < ApplicationRecord
    belongs_to :photo, inverse_of: :questions
    has_many :answers,  inverse_of: :question

end
