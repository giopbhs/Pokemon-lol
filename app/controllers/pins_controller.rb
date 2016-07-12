class PinsController < ApplicationController
	before_action :find_pin, only: [:show, :edit, :update, :destroy, :upvote]
	before_action :authenticate_user!, except: [:index, :show]
	before_action :require_same_user, only: [:edit, :update, :destroy]
	#Requires user except for pins listing and pins show action
	def index
		@pins = Pin.all.order("created_at DESC")
	end

	def show
		 
	end

	def create
		@pin = current_user.pins.build(pin_params)

		if @pin.save
			redirect_to @pin, notice: "Succesfully Created new Post"
		else
			render 'new'
		end
	end

	def new
		@pin = current_user.pins.build
	end

	def edit
		
	end

	def update
		if @pin.update(pin_params)
			redirect_to @pin, notice: "Post was Succesfully updated!"
		else
			render 'edit'
		end
	end

	def destroy
		@pin.destroy
		redirect_to root_path
	end

	def upvote

    @pin = Pin.find(params[:id])
    @pin.upvote_by current_user
    
    redirect_to :back
  	end

	def downvote

    @pin = Pin.find(params[:id])
    @pin.downvote_by current_user
    
    redirect_to :back
  end

	private

	def pin_params
		params.require(:pin).permit(:title, :description, :image)
	end

	def find_pin
		@pin = Pin.find(params[:id])
	end
	#This finds the id of a pin

	def require_same_user
		if current_user != @pin.user
			flash[:danger] = "You can only Edit or Delete your own Post!"
			redirect_to root_path
		end
	end

end
