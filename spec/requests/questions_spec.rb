require 'rails_helper'

RSpec.describe "Questions", type: :request do
  before do
    @user = FactoryBot.create(:user, name: "Tom")
    @other_user = FactoryBot.create(:user, name: "Ben")
    @test_question = FactoryBot.create(:question, body: "Test body", user_id: @user.id)
  end

  context "sign in user" do
    before do
      sign_in(@user)
    end

    it "can see new question button" do
      get(user_feed_path)
      expect(response.body).to include(new_user_question_path(user_id: @user.id))
      expect(response.body).to render_template("users/feed")
    end

    it "can see new question form" do
      get(new_user_question_path(user_id: @user.id))
      expect(response.body).to render_template("questions/new")
    end

    it "can create new question" do
      expect {
        post(user_questions_path(user_id: @user.id), params: {question: {body: "test question", user_id: @user.id}})
        }.to change { Question.count }
    end

    it "can create new answer" do
      expect {
        post(answers_path, params: {answer: {body: "test answer", user_id: @user.id, question_id: @test_question.id}})
        }.to change { Answer.count }
    end

    it "can delete question" do
      expect {
        delete(user_question_path(user_id: @user.id, id: @test_question))
        }.to change { Question.count }
    end

    it "can change question solve status" do
      expect {
        get(edit_user_question_path(user_id: @user.id, id: @test_question))
        }.to change { @test_question.reload.solved }
    end
  end

  context "sign out user" do
    it "can not see new question form" do
      get(new_user_question_path(user_id: @user.id))
      expect(response.code).to include("302")
    end

    it "can not create new question" do
      expect {
        post(user_questions_path(user_id: @user.id), params: {question: {body: "test question", user_id: @user.id}})
        }.not_to change { Question.count }
    end

    it "can not create new answer" do
      expect {
        put(user_question_path(user_id: @user.id, id: @test_question), params: {answer: {body: "test answer", user_id: @user.id, question_id: @test_question.id}})
        }.not_to change { Answer.count }
    end

    it "can not delete question" do
      expect {
        delete(user_question_path(user_id: @user.id, id: @test_question))
        }.not_to change { Question.count }
    end

    it "can not change question solve status" do
      expect {
        get(edit_user_question_path(user_id: @user.id, id: @test_question))
        }.not_to change { @test_question.reload.solved }
    end
  end
end
