class VideosController < ApplicationController
before_action :find_video, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
def index
  @videos = Video.order('created_at DESC')
end

	def new
  @video = current_user.videos.build
end

def create
  @video = current_user.videos.build(params.require(:video).permit(:link))
  
  if @video.save
    flash[:success] = 'Video added!'
    redirect_to videos_path
  else
    render 'new'
  end
end

def upvote

    @video = Video.find(params[:id])
    @video.upvote_by current_user, :vote_weight => 3
    
    redirect_to :back
    end

  def downvote

    @video = Video.find(params[:id])
    @video.downvote_by current_user, :vote_weight => 3
    
    redirect_to :back
  end

  private

    def find_video
    @video = Video.find(params[:id])
  end



end
