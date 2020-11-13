class FamiliesController < ApplicationController
  def index
    @adhesion = Adhesion.new
    sql_query = " \
      adhesions.user_id = :query \
    "
    # @movies = Movie.joins(:director).where(sql_query, query: "%#{params[:query]}%")
    @families = Adhesion.joins(:family).where(sql_query, query: current_user.id).map do |adhesion|
      adhesion.family
    end
    @family = Family.create()
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
    if @adhesion.save
      redirect_to families_path
    else
      render :new
    end
  end

  private

  def family_params
    params.require(:family).permit(:name, :picture)
  end
end
