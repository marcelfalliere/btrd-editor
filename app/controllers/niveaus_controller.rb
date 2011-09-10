
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
  
  # GET /niveaus/serialize/1/
  def serialize
	@niveau = Niveau.find(params[:id])
	File.open(@niveau.file, 'w') do |f| 
		f.puts("<level number='#{@niveau.numero}' tier='#{@niveau.tier}' title='#{@niveau.titre}'>")
		
		@niveau.elements.each do |element|
			currentLine = "\t<#{element.type.xmlTag} x='#{(element.x-0.5) * 16}' y='#{(element.y-0.5) * 16}'"

			element.options.each do |option|
				currentLine << " #{option.name}='#{option.value}'"
			end
			
      if element.type.perfVoisin 
        
        hasOneAbove=false
        hasOneBelow=false
        hasOneOnTheRight=false
        hasOneOnTheLeft=false
        
        if element.x==1
          hasOneOnTheLeft=true
        end
        if element.x==20
          hasOneOnTheRight=true
        end
        if element.y==1
          hasOneBelow=true
        end
        if element.y==30
          hasOneAbove=true
        end
        
        if !hasOneOnTheLeft
          res=Element.where("niveau_id=? and x=? and y=?", @niveau.id,element.x-1, element.y)
          if res.count == 1
            if res[0].type.perfVoisin || res[0].type.id==5|| (res[0].type.id=11 && (res[0].options.first=="NW" || res[0].options.first=="SW"))
              hasOneOnTheLeft=true
            end
          end
        end
        
        if !hasOneOnTheRight
          res=Element.where("niveau_id=? and x=? and y=?", @niveau.id,element.x+1, element.y)
          if res.count == 1
            if res[0].type.perfVoisin || res[0].type.id==5|| (res[0].type.id=11 && (res[0].options.first=="NE" || res[0].options.first=="SE"))
              hasOneOnTheRight=true
            end
          end
        end
        
        if !hasOneBelow
          res=Element.where("niveau_id=? and x=? and y=?", @niveau.id,element.x, element.y-1)
          if res.count == 1
            if res[0].type.perfVoisin || res[0].type.id==5|| (res[0].type.id=11 && (res[0].options.first=="SE" || res[0].options.first=="SW"))
              hasOneBelow=true
            end
          end
        end
        
        if !hasOneAbove
          res=Element.where("niveau_id=? and x=? and y=?", @niveau.id,element.x, element.y+1)
          if res.count == 1
            if res[0].type.perfVoisin || res[0].type.id==5|| (res[0].type.id=11 && (res[0].options.first=="NE" || res[0].options.first=="NW"))
              hasOneAbove=true
            end
          end
        end
        
        currentLine << " hasOneAbove='#{(hasOneAbove)?"1":"0"}' hasOneBelow='#{(hasOneBelow)?"1":"0"}' hasOneOnTheRight='#{(hasOneOnTheRight)?"1":"0"}' hasOneOnTheLeft='#{(hasOneOnTheLeft)?"1":"0"}' "
        
      end
      
			currentLine << "></#{element.type.xmlTag}>"
			
			f.puts(currentLine)
		end
		
		f.puts("</level>")
	end
	
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
    @niveaus = Niveau.order("numero")

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
