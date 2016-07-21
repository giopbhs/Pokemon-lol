class VideosController < ApplicationController
before_action :find_video, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
before_action :authenticate_user!, except: [:index, :show]
def index
  @videos = Video.all.order(:cached_weighted_score => :desc)
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


  private

  def video_params
    params.require(:video).permit(:link)
  end


  def require_same_user
    if current_user != @video.user
      flash[:danger] = "You can only Edit or Delete your own Post!"
      redirect_to root_path
    end
  end

end
