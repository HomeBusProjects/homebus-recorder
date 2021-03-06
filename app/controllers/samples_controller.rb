class SamplesController < ApplicationController
  before_action :set_sample, only: [:show, :edit, :update, :destroy]

  # GET /samples
  # GET /samples.json
  def index
    @active_ddc = ''
    @active_source = ''
    @ddcs = [ '' ] + Ddc.order(name: :asc).pluck(:name)

    @samples = Sample.order(created_at: :desc).paginate(page: params[:page], total_entries: 1000, per_page: params[:per_page])

    if params[:ddc]
      @samples = @samples.where(ddc: params[:ddc])
      @active_ddc = params[:ddc]
    end

    if params[:source]
      @samples = @samples.where(uuid: params[:source])
      @active_source = params[:source]
    end

    if params[:interval]
      @samples = @samples.where('created_at > ?', Time.now - params[:interval].to_i)
    end

    logger.unknown "SAMPLES INDEX"
    logger.unknown @samples.explain
  end

  # GET /samples/1
  # GET /samples/1.json
  def show
  end

  # GET /samples/new
  def new
    @sample = Sample.new
  end

  # GET /samples/1/edit
  def edit
  end

  # POST /samples
  # POST /samples.json
  def create
    @sample = Sample.new(sample_params)

    respond_to do |format|
      if @sample.save
        format.html { redirect_to @sample, notice: 'Sample was successfully created.' }
        format.json { render :show, status: :created, location: @sample }
      else
        format.html { render :new }
        format.json { render json: @sample.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /samples/1
  # PATCH/PUT /samples/1.json
  def update
    respond_to do |format|
      if @sample.update(sample_params)
        format.html { redirect_to @sample, notice: 'Sample was successfully updated.' }
        format.json { render :show, status: :ok, location: @sample }
      else
        format.html { render :edit }
        format.json { render json: @sample.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /samples/1
  # DELETE /samples/1.json
  def destroy
    @sample.destroy
    respond_to do |format|
      format.html { redirect_to samples_url, notice: 'Sample was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sample
      @sample = Sample.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sample_params
      params.require(:sample).permit(:uuid, :source, :ddc, :data, :interval, :per_page)
    end
end
