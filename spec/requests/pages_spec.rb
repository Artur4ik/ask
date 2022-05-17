require 'rails_helper'

RSpec.describe "Pages", type: :request do
  it "get home page" do
    get(home_path)
    expect(response.body).to render_template("pages/home")
  end

  it "get about page" do
    get(about_path)
    expect(response.body).to render_template("pages/about")
  end
end
