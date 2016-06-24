module ApplicationHelper
  def parent_pack
    @parent ||= current_user.packs.find_by(id: params[:pack_id])
  end
end
