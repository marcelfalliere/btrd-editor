class MainconfigsController < ApplicationController
  # GET /mainconfigs
  # GET /mainconfigs.xml
  def index
    @mainconfigs = Mainconfig.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mainconfigs }
    end
  end

  # GET /mainconfigs/1
  # GET /mainconfigs/1.xml
  def show
    @mainconfig = Mainconfig.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @mainconfig }
    end
  end

  # GET /mainconfigs/new
  # GET /mainconfigs/new.xml
  def new
    @mainconfig = Mainconfig.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @mainconfig }
    end
  end

  # GET /mainconfigs/1/edit
  def edit
    @mainconfig = Mainconfig.find(params[:id])
  end

  # POST /mainconfigs
  # POST /mainconfigs.xml
  def create
    @mainconfig = Mainconfig.new(params[:mainconfig])

    respond_to do |format|
      if @mainconfig.save
        format.html { redirect_to(@mainconfig, :notice => 'Mainconfig was successfully created.') }
        format.xml  { render :xml => @mainconfig, :status => :created, :location => @mainconfig }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @mainconfig.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /mainconfigs/1
  # PUT /mainconfigs/1.xml
  def update
    @mainconfig = Mainconfig.find(params[:id])

    respond_to do |format|
      if @mainconfig.update_attributes(params[:mainconfig])
        format.html { redirect_to(niveaus_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @mainconfig.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /mainconfigs/1
  # DELETE /mainconfigs/1.xml
  def destroy
    @mainconfig = Mainconfig.find(params[:id])
    @mainconfig.destroy

    respond_to do |format|
      format.html { redirect_to(mainconfigs_url) }
      format.xml  { head :ok }
    end
  end
end
