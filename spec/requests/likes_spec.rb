require 'rails_helper'

RSpec.describe "Likes", type: :request do
  before do
    @user = FactoryBot.create(:user, name: "Tom")
    @test_question = FactoryBot.create(:question, body: "Test body", user_id: @user.id)
    @test_answer = FactoryBot.create(:answer, body: "Test body", user_id: @user.id, question_id: @test_question.id)
    @like_params = {target_id: 1, target_type: "Q", user_id: @user.id, emoji: Emoji.find_by_alias('hankey').name}
  end

  context "sign in user" do
    before do
      sign_in(@user)
    end

    it "can create like on question" do
      @like_params[:target_type] = "Q"

      expect {
        post(likes_path(@like_params))
        }.to change { Like.count }
    end

    it "can create like on answer" do
      @like_params[:target_type] = "A"

      expect {
        post(likes_path(@like_params))
        }.to change { Like.count }
    end

    it "can not create like with invalid target id" do
      @like_params[:target_id] = "fOoBaR"

      expect {
        post(likes_path(@like_params))
        }.not_to change { Like.count }
    end

    it "can not create like with invalid target type" do
      @like_params[:target_type] = "fOoBaR"

      expect {
        post(likes_path(@like_params))
        }.not_to change { Like.count }
    end

    it "can not create like with invalid user id" do
      @like_params[:user_id] = "fOoBaR"

      expect {
        post(likes_path(@like_params))
        }.not_to change { Like.count }
    end
  end

  context "sign out user" do
    it "can not create like" do
      expect {
        post(likes_path(@like_params))
        }.not_to change { Like.count }
    end
  end
end
