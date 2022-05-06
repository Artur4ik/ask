module Handlers
  class LikesHandler
    def initialize(params)
      @like = params
    end

    def perform
      Like.exists?(@like) ? Like.find_by(@like).destroy : Like.create(@like)
      Like.where(target_id: @like['target_id'], target_type: @like['target_type'])
    end
  end

  class QuestionsHandler
    def add_question(body, user_id)
      is_valid_user = User.exists?(id: user_id)
      is_body_not_empty = !body.blank?

      messages = Array.new
      if (is_valid_user && is_body_not_empty)
        Question.create({body: body, user_id: user_id})
        messages.push('question_created')
      else
        messages.push('user_not_exist') unless is_valid_user
        messages.push('question_body_empty') unless is_body_not_empty
      end
    end

    def add_answer(body, user_id, question_id)
      is_valid_user = User.exists?(id: user_id)
      is_valid_question = Question.exists?(id: question_id)
      is_body_not_empty = !body.blank?

      messages = Array.new
      if (is_valid_user && is_valid_question && is_body_not_empty)
        Answer.create({body: body, user_id: user_id, question_id: question_id})
        messages.push('answer_created')
      else
        messages.push('user_not_exist') unless is_valid_user
        messages.push('question_not_exist') unless is_valid_question
        messages.push('answer_body_empty') unless is_body_not_empty
      end
    end

    def delete_question(question_id)
      is_valid_question = Question.exists?(id: question_id)

      messages = Array.new
      if is_valid_question
        answers = Answer.where(question_id: question_id).delete_all
        answers.each do |answer|
          Like.where(target_id: answer.id, target_type: "A").delete_all
        end
        Like.where(target_id: question_id, target_type: "Q").delete_all
        Question.find_by(id: question_id).destroy
        messages.push('question_deleted')
      else
        messages.push('question_not_exist') unless is_valid_question
      end
    end

    def change_solved_status(question_id)
      is_valid_question = Question.exists?(id: question_id)

      messages = Array.new
      if is_valid_question
        Question.find_by(id: question_id).toggle!(:solved)
        messages.push('question_status_changed')
      else
        messages.push('question_not_exist') unless is_valid_question
      end
    end
  end
end
