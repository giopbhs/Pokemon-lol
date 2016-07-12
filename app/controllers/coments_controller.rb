class ComentsController < ApplicationController
  before_action :set_coment, only: [:show, :edit, :update, :destroy]

  def index
    @coments = Coment.all
  end

  def create
    @pin = Pin.find(params[:pin_id])
    @coment = @pin.coments.new(coment_params)
    @coment.user = current_user

    respond_to do |format|
      if @coment.save
        format.html { redirect_to @pin, notice: 'comment was successfully created.' }
        format.json { render json: @coment, status: :created, location: @coment }
      else
        format.html { render action: "new" }
        format.json { render json: @coment.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /coments/1
  # DELETE /coments/1.json
  def destroy
    @coment.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coment
      @coment = Coment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coment_params
      params.require(:coment).permit(:pin_id, :body, :user_id)
    end
end
