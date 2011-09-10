class ElementsController < ApplicationController

  layout nil

  #GET /elements/details
  def details
	x=params[:x]
	y=params[:y]
	niveau_id=params[:niveauId]
	
	res = Element.where("niveau_id=? AND x=? AND y=?", niveau_id, x, y)
	if res.size == 0
		redirect_to :controller=>'elements', :action=>'new', :y=>y, :x=>x, :niveauId=>niveau_id
	else 
		if res.size == 1
			redirect_to :controller=>'elements', :action=>'edit', :id=>res[0].id
		else 
			render :text=>"error"
		end
	end
	
  end
  

  # GET /elements
  # GET /elements.xml
  def index
    @elements = Element.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @elements }
    end
  end


  # GET /elements/new
  # GET /elements/new.xml
  def new
    @element = Element.new

	x=params[:x]
	y=params[:y]
	niveau_id=params[:niveauId]
	
	@element.x=x
	@element.y=y
	@element.niveau_id=niveau_id
	
	@types = Type.find(:all)
	@selected_type = @types.first
	
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @element }
    end
  end

  # GET /elements/1/edit
  def edit
    @element = Element.find(params[:id])
	@types = Type.find(:all)
	@selected_type = @types.first
  end

  # POST /elements
  # POST /elements.xml
  def create
    @element = Element.new(params[:element])

	
    if @element.save
      render :text => 'Element was successfully created.'
    else
      render :text => 'Error creating this element.'
    end
    
  end

  # PUT /elements/1
  # PUT /elements/1.xml
  def update
    @element = Element.find(params[:id])

    if @element.update_attributes(params[:element])
      render :text => 'Element was successfully update.'
    else
      render :text => 'Error updating this element.'
    end
    
  end

  # POST /elements/delete/1
  def delete
    @element = Element.find(params[:id])
    @element.destroy

    render :text => 'Element destroyed'
  end
end
