require "test_helper"

class QuestionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:tom)
    @other_user = users(:foobar)
    @test_question = questions(:test_question)
  end

  test "signed in user can see new question button" do
    sign_in(@user)
    get(user_feed_path)
    assert_select("a[href=?]", new_user_question_path(user_id: @user.id))
    assert_template('users/feed')
  end

  test "signed in user can see new question form" do
    sign_in(@user)
    get(new_user_question_path(user_id: @user.id))
    assert_equal(request.path, new_user_question_path(user_id: @user.id))
    assert(response.ok?)
    assert_template('questions/new')
  end

  test "not signed in user can't see new question form" do
    get(new_user_question_path(user_id: @user.id))
    assert_equal(request.path, new_user_question_path(user_id: @user.id))
    assert_equal(response.code, "302")
    assert_redirected_to(new_user_session_path)
  end

  test "not signed in user can't create new question" do
    assert_no_difference('Question.count') do
      post(user_questions_path(user_id: @user.id), params: {question: {body: "test question", user_id: @user.id}})
    end
  end

  test "signed in user can create new question" do
    sign_in(@user)
    assert_difference('Question.count') do
      post(user_questions_path(user_id: @user.id), params: {question: {body: "test question", user_id: @user.id}})
    end
  end

  test "not signed in user can't create new answer" do
    assert_no_difference('Answer.count') do
      put(user_question_path(user_id: @user.id, id: @test_question), params: {answer: {body: "test question", user_id: @user.id, question_id: @test_question.id}})
    end
  end

  test "signed in user can create new answer" do
    sign_in(@user)
    assert_difference('Answer.count') do
      put(user_question_path(user_id: @user.id, id: @test_question), params: {answer: {body: "test answer", user_id: @user.id, question_id: @test_question.id}})
    end
  end

  test "user can delete question" do
    sign_in(@user)
    assert_difference('Question.count', -1) do
      delete(user_question_path(user_id: @user.id, id: @test_question))
    end
  end

  test "only owner user can delete question" do
    sign_in(@other_user)
    assert_no_difference('Question.count') do
      delete(user_question_path(user_id: @user.id, id: @test_question))
    end
  end

  test "user can change question solve status" do
    sign_in(@user)
    assert_changes('@test_question.solved') do
      get(edit_user_question_path(user_id: @user.id, id: @test_question))
      @test_question.reload
    end
  end

  test "only owner user can change question solve status" do
    sign_in(@other_user)
    assert_no_changes('@test_question.solved') do
      get(edit_user_question_path(user_id: @user.id, id: @test_question))
      @test_question.reload
    end
  end
end
