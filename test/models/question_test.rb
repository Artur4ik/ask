require "test_helper"

class QuestionTest < ActiveSupport::TestCase
  def setup
    @user = users(:tom)
  end

  test "should create question" do
    @question = @user.questions.build(body: "foobar")
    assert(@question.valid?)
  end

  test "should not create blank question" do
    @question = @user.questions.build(body: "")
    assert_not(@question.valid?)
  end

  test "should not create question with invalid user id" do
    @question = @user.questions.build(body: "foobar")
    @question.user_id = nil
    assert_not(@question.valid?)
  end
end
