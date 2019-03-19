class MainController < ApplicationController


  def initialize
    super
    @status = false
  end

  def index
  end

  def stop
    @status = false
    @res = { "res" => @status }
    render :json => @res 
  end

  def start
    @status = true
    @res = { "res" => @status }
    render :json => @res 
  end

  def status
    @res = { "res" => @status }
    render :json => @res 
  end

end
