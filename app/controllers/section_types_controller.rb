class SectionTypesController < ApplicationController
  # GET /section_types
  # GET /section_types.xml
  def index
    @section_types = SectionType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @section_types }
    end
  end

  # GET /section_types/1
  # GET /section_types/1.xml
  def show
    @section_type = SectionType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @section_type }
    end
  end

  # GET /section_types/new
  # GET /section_types/new.xml
  def new
    @section_type = SectionType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @section_type }
    end
  end

  # GET /section_types/1/edit
  def edit
    @section_type = SectionType.find(params[:id])
  end

  # POST /section_types
  # POST /section_types.xml
  def create
    @section_type = SectionType.new(params[:section_type])

    respond_to do |format|
      if @section_type.save
        flash[:notice] = 'SectionType was successfully created.'
        format.html { redirect_to(@section_type) }
        format.xml  { render :xml => @section_type, :status => :created, :location => @section_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @section_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /section_types/1
  # PUT /section_types/1.xml
  def update
    @section_type = SectionType.find(params[:id])

    respond_to do |format|
      if @section_type.update_attributes(params[:section_type])
        flash[:notice] = 'SectionType was successfully updated.'
        format.html { redirect_to(@section_type) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @section_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /section_types/1
  # DELETE /section_types/1.xml
  def destroy
    @section_type = SectionType.find(params[:id])
    @section_type.destroy

    respond_to do |format|
      format.html { redirect_to(section_types_url) }
      format.xml  { head :ok }
    end
  end
end
