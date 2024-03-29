class AdhesionsController < ApplicationController
  def create
    Adhesion.create!(family_id: params[:adhesion][:family_id], user_id: params[:adhesion][:user])
    redirect_to dashboard_path(current_user)
  end

  def destroy
    ids = params[:id].split("_")
    @adhesion = Adhesion.where(user_id: ids[1], family_id: ids[0])
    @adhesion.first.destroy
    redirect_to dashboard_path(current_user)
  end

  private

  def adhesion_params
    params.require(:adhesion).permit(:adhesion, :id)
  end
end
