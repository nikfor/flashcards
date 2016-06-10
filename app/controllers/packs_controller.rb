class PacksController < ApplicationController

  before_action :find_pack, only: [:edit, :update, :destroy, :current_pack]

  def index
    @packs = current_user.packs
  end

  def new
    @pack = Pack.new
  end

  def create
    @pack = current_user.packs.new(pack_params)
    if @pack.save
      redirect_to packs_path, :alert => t('pack.success_create')
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @pack.update(pack_params)
      redirect_to packs_path, :alert => t('pack.success_update')
    else
      render "edit"
    end
  end

  def destroy
    @pack.cards.destroy_all
    @pack.destroy
    redirect_to packs_path, :alert => t('pack.success_destroy')
  end

  def current_pack
    current_user.packs.update_all(current: false)
    @pack.update_attributes(current: true)
    redirect_to packs_path, :alert => "#{@pack.name} #{t('pack.is_current')}"
  end

  private

  def pack_params
    params.require(:pack).permit(:name)
  end

  def find_pack
    @pack = current_user.packs.find_by(id: params[:id])
    render_404 unless @pack
  end

end
