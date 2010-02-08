class QuipsController < ApplicationController
  # GET /quips
  # GET /quips.xml
  def index
    @quips = Quip.find(:all)
    @random_quip = @quips[rand(@quips.length)]

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @quips }
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
        if Quip.increment_counter(:votes, params[:id]) 
            flash[:notice] = 'Vote added.'
        else
            flash[:notice] = 'Could not add vote.'
        end
      elsif params[:type] == "down"
        if Quip.decrement_counter(:votes, params[:id]) 
            flash[:notice] = 'Vote added.'
        else
            flash[:notice] = 'Could not add vote.'
        end
      else
          flash[:notice] = 'Vote type not specified.'
      end 
      redirect_to quips_url
  end
end
