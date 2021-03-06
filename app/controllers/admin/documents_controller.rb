class Admin::DocumentsController < Admin::ApplicationController
  load_and_authorize_resource
  
  respond_to :html, :xml, :json, :js
  
  # GET /documentDocument
  # GET /Documents.json
  def index
    @documents = Document.all
    
    respond_with(@documents)
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
    @document = Document.find(params[:id])

    respond_with(@document)
  end

  # GET /documents/new
  # GET /documents/new.json
  def new
    @document = Document.new

    respond_with(@document)
  end

  # GET /documents/1/edit
  def edit
    @document = Document.find(params[:id])
  end

  # POST /documents
  # POST /documents.json
  def create
    #loop on each file from array and create document
    params[:document][:filearrays].each do |file|
      @document = Document.new(:document => file, :animal_id => params[:document][:animal_id])
      if @document.save
        flash[:notice] = 'Successfully uploaded the document.'
      else
        flash[:error] = 'There was a problem uploading the document.'
      end
    end
    
    redirect_to :back
  end

  # PUT /documents/1
  # PUT /documents/1.json
  def update
    @document = Document.find(params[:id])
    @document.update_attributes(params[:document])
    
    respond_with(@document)
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document = Document.find(params[:id])
    @document.destroy
    flash[:notice] = 'Successfully destroyed document.'
    
    redirect_to :back
  end
end