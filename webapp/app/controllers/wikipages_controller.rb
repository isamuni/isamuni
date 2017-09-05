class WikipagesController < ApplicationController
  before_action :set_wikipage, only: [:show, :edit, :update, :destroy]
  before_action :check_permissions, only: [:edit, :update, :destroy]
  
  # GET /wikipages
  # GET /wikipages.json
  def index
    @wikipages = Wikipage.all
  end

  # GET /wikipages/1
  # GET /wikipages/1.json
  def show
  end

  # GET /wikipages/new
  def new
    @wikipage = Wikipage.new
  end

  # GET /wikipages/1/edit
  def edit
  end

  # POST /wikipages
  # POST /wikipages.json
  def create
    @wikipage = Wikipage.new(wikipage_params)

    respond_to do |format|
      if @wikipage.save
        format.html { redirect_to @wikipage, notice: 'Wikipage was successfully created.' }
        format.json { render :show, status: :created, location: @wikipage }
      else
        format.html { render :new }
        format.json { render json: @wikipage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wikipages/1
  # PATCH/PUT /wikipages/1.json
  def update
    respond_to do |format|
      if @wikipage.update(wikipage_params)
        format.html { redirect_to @wikipage, notice: 'Wikipage was successfully updated.' }
        format.json { render :show, status: :ok, location: @wikipage }
      else
        format.html { render :edit }
        format.json { render json: @wikipage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wikipages/1
  # DELETE /wikipages/1.json
  def destroy
    @wikipage.destroy
    respond_to do |format|
      format.html { redirect_to wikipages_url, notice: 'Wikipage was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def check_permissions
      unless current_user&.admin? or current_user&.editor?
        redirect_to wikipages_url,
          notice: 'Devi essere un editor per effettuare questa azione! Contattaci!'
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_wikipage
      @wikipage = Wikipage.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wikipage_params
      params.require(:wikipage).permit(:name, :slug, :content)
    end
end
