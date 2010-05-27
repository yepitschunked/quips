class QuipsController < ApplicationController
  verify :xhr => true, :only => :ajax_autocomplete
  # GET /quips
  # GET /quips.xml
  def index
    @quips = Quip.paginate :page => params[:page], :order => 'created_at DESC'

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @quips }
    end
  end

  def ajax_autocomplete
      @query = params[:query]
      if @query.blank?
        @results = []
      else
          @results = Quip.find(:all, :conditions => [ "quip like ?", "%#{@query}%" ])
      end
      respond_to do |format|
        format.json { render :json => @results.to_json(:only => [:id, :quip]) }
      end
  end

  # GET /quips/1
  # GET /quips/1.xml
  def show
    if params[:id] == "random" then
        @quip = Quip.find(:first, :offset => rand(Quip.count))
    else
        @quip = Quip.find(params[:id])
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @quip }
    end
  end

  # GET /quips/new
  # GET /quips/new.xml
  def new
    @quip = Quip.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @quip }
    end
  end

  # GET /quips/1/edit
  def edit
    @quip = Quip.find(params[:id])
  end

  # POST /quips
  # POST /quips.xml
  def create
    params[:quip][:votes] = 0
    @quip = Quip.new(params[:quip])

    respond_to do |format|
      if @quip.save
        flash[:notice] = 'Quip was successfully created.'
        format.html { redirect_to(@quip) }
        format.xml  { render :xml => @quip, :status => :created, :location => @quip }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @quip.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /quips/1
  # PUT /quips/1.xml
  def update
    @quip = Quip.find(params[:id])

    respond_to do |format|
      if @quip.update_attributes(params[:quip])
        flash[:notice] = 'Quip was successfully updated.'
        format.html { redirect_to(@quip) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @quip.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /quips/1
  # DELETE /quips/1.xml
  def destroy
    @quip = Quip.find(params[:id])
    @quip.destroy

    respond_to do |format|
      format.html { redirect_to(quips_url) }
      format.xml  { head :ok }
    end
  end
  def vote
      if params[:type] == "up" 
        Quip.increment_counter(:votes, params[:id]) 
      elsif params[:type] == "down"
        Quip.decrement_counter(:votes, params[:id]) 
      end
      render :text => Quip.find(params[:id]).votes
  end
end
