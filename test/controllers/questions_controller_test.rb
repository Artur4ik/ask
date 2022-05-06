require "test_helper"

class QuestionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:test_user)
    sign_in(@user)
    @test_question = questions(:test_question)
  end

  test "should create questions links" do
    get root_path
    assert_select "a[href=?]", new_question_path
    assert_select "form[action=?]", new_question_path
    assert_template 'questions/index'
  end

  test "should get index" do
    get questions_path
    assert_template("questions/index")
  end

  test "should get question page" do
    get question_path(id: @test_question.id)
    assert_template("questions/show")
  end

  test "should get user page" do
    get user_registration_path + "/#{@user.id}"
    assert_template("questions/user")
  end

  test "should get new question page" do
    get new_question_path
    assert_template("questions/new")
  end

  test "should create new question" do
    assert_difference('Question.count') do
      post questions_path, params: {question: {body: "foobar", user_id: @user.id}}
    end
    question_id = Question.find_by(user_id: @user.id, body: "foobar").id
    assert_redirected_to(question_path(id: question_id))
  end

  test "should not create blank question" do
    assert_no_difference('Question.count') do
      post questions_path, params: {question: {body: "", user_id: @user.id}}
    end
    assert_redirected_to(new_question_path)
  end

  test "should delete question" do
    assert_difference('Question.count', -1) do
      delete question_path(id: @test_question.id)
    end
    assert_redirected_to(questions_path)
  end

  test "should add answer to question" do
    assert_difference('Answer.count') do
      put question_path(id: @test_question.id), params: { answer: {body: "foobar", user_id: @user.id, question_id: @test_question.id} }
    end
    assert_redirected_to(id: @test_question.id)
  end

  test "should not add blank answer to question" do
    assert_no_difference('Answer.count') do
      put question_path(id: @test_question.id), params: { answer: {body: "", user_id: @user.id, question_id: @test_question.id} }
    end
    assert_redirected_to(id: @test_question.id)
  end

  test "should change question solve status" do
    assert_changes('@test_question.solved') do
      get edit_question_path(id: @test_question.id)
      @test_question.reload
    end
  end
end
