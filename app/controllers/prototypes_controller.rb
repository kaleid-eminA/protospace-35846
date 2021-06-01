class PrototypesController < ApplicationController
 
  before_action :set_prototype, only: [:destroy, :edit, :show, :update]
  before_action :move_to_index, except: [:index, :show, :new, :create] #except は"それ以外" という意味/move_to_indexを使わないものを指定


  def index
    @prototype = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :_form
  end
end

def destroy
      @prototype.destroy
      redirect_to root_path
end

  def show
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
  end

  def update
    if @prototype.update(prototype_params)
        redirect_to prototype_path(@prototype.id), method: :get
    else
      render :edit
  end
end



  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def move_to_index
    unless user_signed_in? && current_user.id == @prototype.user.id
      redirect_to action: :index
    end
  end
  
end
