class FamiliesController < ApplicationController
  def index
    @families = Family.all
  end

  def show
    @family = Family.find(params[:id])
    @adhesion = Adhesion.new
  end
  def create
    @family = Family.create(family_params)
    @adhesion = Adhesion.new
    @adhesion.user = current_user
    @adhesion.family = @family
    @adhesion.save!
    redirect_to books_path
  end


  private

  def family_params
    params.require(:family).permit(:name)
  end

end
