
class NiveausController < ApplicationController
  
  # POST /niveaus/fastedit/1/
  def fastedit
	@niveau=Niveau.find(params[:id])
	type_id=params[:fastedittype]
	coordinates=params[:coordinates]
	
	tab_coordinates=coordinates.split(";")
	tab_coordinates.each do |coordinate|
		x=coordinate[1,coordinate.index(",")-1].to_i
		y=coordinate[coordinate.index(",")+1,coordinate.rindex("]")-3].to_i
		
		if type_id=="delete"
		  Element.where("x=? and y=? and niveau_id=?", x, y, @niveau.id).delete_all
		else
		  new_element=Element.new({:x=>x, :y=>y, :type_id=>type_id, :niveau_id=>@niveau.id})
		  new_element.save
		end
	end
	
	render :text=>"Saved !!", :layout=>false
  end
  
  # POST /niveaus/serialize_all
  def serialize_all
    Niveau.where("isRealyDeleted=?", false).each do |n|
      n.serialize
    end
    redirect_to niveaus_path
  end
  
  # GET /niveaus/serialize/1/
  def serialize
	  @niveau = Niveau.find(params[:id])
	  @niveau.serialize
	  redirect_to edit_niveau_path(@niveau)
  end
  
  # GET /niveaus/screen/1/
  def screen
	@niveau = Niveau.find(params[:id])
	render :layout=>false
  end
  
  # GET /niveaus
  # GET /niveaus.xml
  def index
    @niveaus = Niveau.order("isReallyDeleted, isTest,tier asc,numero")
    @mainconfig = Mainconfig.find(1)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @niveaus }
    end
  end

  # GET /niveaus/1
  # GET /niveaus/1.xml
  def show
    @niveau = Niveau.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @niveau }
    end
  end

  # GET /niveaus/new
  def new
    @niveau = Niveau.new
  end

  # GET /niveaus/1/edit
  def edit
    @niveau = Niveau.find(params[:id])
	@niveaus = Niveau.where("isReallyDeleted=? and isTest=?",false,false).order("tier asc,numero")
	@types = Type.find(:all)
  end

  # POST /niveaus
  def create
    @niveau = Niveau.new(params[:niveau])

    if @niveau.save
      redirect_to edit_niveau_path(@niveau)
    else
      render :action => "new"
    end
  end

  # PUT /niveaus/1
  # PUT /niveaus/1.xml
  def update
    @niveau = Niveau.find(params[:id])

	if @niveau.update_attributes(params[:niveau])
	  redirect_to edit_niveau_path(@niveau)
	else
	  render :action => "edit" 
	end
  end

  # DELETE /niveaus/1
  # DELETE /niveaus/1.xml
  def destroy
    @niveau = Niveau.find(params[:id])
    @niveau.destroy

    respond_to do |format|
      format.html { redirect_to(niveaus_url) }
      format.xml  { head :ok }
    end
  end
end
