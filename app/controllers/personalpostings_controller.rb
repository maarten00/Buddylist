class PersonalpostingsController < ApplicationController

  def create
    @personalposting = Personalposting.new(user_id: current_user.id, content: personalposting_params['content'], receiver_id: personalposting_params['receiver_id'])
    respond_to do |format|
      if @personalposting.save
        format.html { redirect_to User.find(personalposting_params['receiver_id']), notice: 'Posted message to wall' }
        format.json { render action: 'show', controller: users, status: :created, location: User.find(personalposting_params['receiver_id']) }
      else
        format.html { render action: 'show', location: user.find(personalposting_params['receiver_id']) }
        format.json { render json: @personalposting.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def personalposting_params
    params.require(:personalposting).permit(:user_id, :content, :receiver_id)
  end
end
