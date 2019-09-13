class Answer < ApplicationRecord
    belongs_to :user,  inverse_of: :answers
    belongs_to :question,  inverse_of: :answers
end
