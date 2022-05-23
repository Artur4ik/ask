class AnswersController < ApplicationController
  def update
    answer = Answer.find(params[:id])
    if(current_user.id == answer.user_id)
      answer.update_attribute(:body, params[:body])
      render(json: answer)
    else
      render(html: "Error")
    end
  end

  def destroy
    answer = Answer.find(params[:id])
    if(current_user.id == answer.user_id)
      answer.destroy
      render(json: "OK")
    else
      render(html: "Error")
    end
  end
end
