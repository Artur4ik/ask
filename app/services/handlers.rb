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
end
