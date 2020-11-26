class FamiliesController < ApplicationController
  before_action :family_select, only: %i[show edit destroy update]

  def index
    @families = current_user.families.includes(users: [avatar_attachment: :blob])
    @family = Family.new
  end

  def create
    family = Family.create!(family_params).update!(familyadmin_id: current_user.id)
    Adhesion.create!(user_id: current_user.id, family_id: Family.last.id)
    redirect_to dashboard_path(current_user)
  end

  def destroy
    return unless @family.familyadmin_id == current_user.id

    @family.destroy
    redirect_to dashboard_path(current_user)
  end

  def update
    return unless @family.familyadmin_id == current_user.id

    @family.update(family_params)
    redirect_to dashboard_path(current_user)
  end

  private

  def family_select
    @family = Family.find(params[:id])
  end

  def family_params
    params.require(:family).permit(:name, :picture)
  end
end
