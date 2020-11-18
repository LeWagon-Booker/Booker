class AdhesionsController < ApplicationController
  def create
    @adhesion = Adhesion.new(adhesion_params)
    @adhesion.family = Family.find(params[:family_id])
    @adhesion.save!
    redirect_to families_path
  end

  private

  def adhesion_params
    params.require(:adhesion).permit(:user_id)
  end
end
