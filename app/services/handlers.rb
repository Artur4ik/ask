module Handlers
  class LikesHandler
    def initialize(params)
      @like = params
    end

    def perform
      Like.exists?(@like) ? Like.find_by(@like).destroy : Like.create(@like)
      Like.where(target_id: @like['target_id'], target_type: @like['target_type'], emoji: @like['emoji'])
    end
  end

  class QuestionsHandler
    def initialize
      @msg = MessagesHandler.new
    end

    def add_question(body, user_id)
      is_valid_user = User.exists?(id: user_id)
      is_body_not_empty = !body.blank?

      if (is_valid_user && is_body_not_empty)
        Question.create({body: body, user_id: user_id})
        @msg.add_message('question_created', 'success')
      else
        @msg.add_message('user_not_exist', 'danger') unless is_valid_user
        @msg.add_message('question_body_empty', 'danger') unless is_body_not_empty
      end

      @msg
    end

    def add_answer(body, user_id, question_id)
      is_valid_user = User.exists?(id: user_id)
      is_valid_question = Question.exists?(id: question_id)
      is_body_not_empty = !body.blank?

      if (is_valid_user && is_valid_question && is_body_not_empty)
        Answer.create({body: body, user_id: user_id, question_id: question_id})
        @msg.add_message('answer_created', 'success')
      else
        @msg.add_message('user_not_exist', 'danger') unless is_valid_user
        @msg.add_message('question_not_exist', 'danger') unless is_valid_question
        @msg.add_message('answer_body_empty', 'danger') unless is_body_not_empty
      end

      @msg
    end

    def delete_question(question_id)
      is_valid_question = Question.exists?(id: question_id)

      if is_valid_question
        answers = Answer.where(question_id: question_id)
        answers.each do |answer|
          Like.where(target_id: answer.id, target_type: "A").delete_all
        end
        Answer.where(question_id: question_id).delete_all
        Like.where(target_id: question_id, target_type: "Q").delete_all
        Question.find_by(id: question_id).destroy
        @msg.add_message('question_deleted', 'success')
      else
        @msg.add_message('question_not_exist', 'danger') unless is_valid_question
      end

      @msg
    end

    def change_solved_status(question_id)
      is_valid_question = Question.exists?(id: question_id)

      if is_valid_question
        Question.find_by(id: question_id).toggle!(:solved)
        @msg.add_message('question_status_changed', 'success')
      else
        @msg.add_message('question_not_exist', 'danger') unless is_valid_question
      end

      @msg
    end
  end

  class MessagesHandler < Hash
    def add_message(message_string, alert_type)
      self['questions.' + message_string] = alert_type
    end

    def success?
      return self.has_value?('success')
    end
  end
end
