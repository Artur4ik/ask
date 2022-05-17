require 'rails_helper'

RSpec.describe "Users", type: :request do
  fixtures :all

  context "sign in user" do
    before do
      @user = users(:tom)
      sign_in(@user)
    end

    it "can see feed" do
      get(user_feed_path)
      expect(response.body).to render_template("users/feed")
    end

    it "can see my profile buttons" do
      get(user_feed_path)
      expect(response.body).to include(user_questions_path(user_id: @user.id)).at_least(2).times
    end

    it "can see my feed buttons" do
      get(user_feed_path)
      expect(response.body).to include(user_feed_path)
    end

    it "can see common feed buttons" do
      get(user_feed_path)
      expect(response.body).to include(users_path)
    end
  end

  context "sign out user" do
    before do
      @user = users(:tom)
    end

    it "can not see feed" do
      get(user_feed_path)
      expect(response.code).to include("302")
      expect(response.body).not_to render_template("users/feed")
    end

    it "can not see my profile buttons" do
      get(user_feed_path)
      expect(response.body).not_to include(user_questions_path(user_id: @user.id)).at_least(2).times
    end

    it "can not see my feed buttons" do
      get(user_feed_path)
      expect(response.body).not_to include(user_feed_path)
    end

    it "can not see common feed buttons" do
      get(user_feed_path)
      expect(response.body).not_to include(users_path)
    end
  end
end
