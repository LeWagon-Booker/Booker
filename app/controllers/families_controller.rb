class FamiliesController < ApplicationController
  before_action :family_select, only: %i[show edit destroy update]

  def index
    @families = current_user.families.includes(users: [avatar_attachment: :blob])
    @family = Family.new
  end

  def create
    Family.create!(family_params)
    Adhesion.create!(user_id: current_user.id, family_id: Family.last.id)
    redirect_to families_path
  end

  def destroy
    @family.destroy
    redirect_to families_path
  end

  def update
    @family.update(family_params)
    redirect_to families_path
  end

  private

  def family_select
    @family = Family.find(params[:id])
  end

  def family_params
    params.require(:family).permit(:name, :picture)
  end
end
