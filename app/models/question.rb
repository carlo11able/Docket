class Question < ApplicationRecord
    belongs_to :photo, inverse_of: :questions
    has_many :answers,  inverse_of: :question

    #scope :owner, -> { joins(:photo).where(photo: { id: nil }) }
    # select(:user_id).joins(:photo)

    #scope :owner, -> {Question.select(:"photos.user_id").joins(:photo)}
    def count_answer()
        Answer.where(question_id: self.id).count
    end

    def count_answer1()
        Answer.where(question_id: self.id).where(answer: 1).count
    end

    def count_answer2()
        Answer.where(question_id: self.id).where(answer: 2).count
    end
    

end
