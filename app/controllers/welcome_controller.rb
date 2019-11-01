class WelcomeController < ApplicationController
  require 'net/http'  
  def index
  end
  def search
    empty_folder
    @link = params[:q]
    
    # Check link, modify it to API
    
    @link = @link.gsub(/ /, "")
    if !@link.match(/http/)
      @link = "https://" + @link
    elsif !@link.match(/https/)
      @link = @link.gsub(/http/, "https")
    end
    if @link.match(/github.com/) ## Check, if user enters valid URL
      @link = @link.gsub(/github.com/, "api.github.com/repos") + "/contributors"
      ####
      
      uri = URI(@link)
      response = Net::HTTP.get(uri)
      @hash = JSON.parse(response)
      @contributors = Array.new()
      puts "link #{@link}"
      for i in 1..3
        if @hash[i]
          @contributors.push(Contributors.new i, @hash[i]['login'], @hash[i]["html_url"])
        end
      end
      @contributors.each do |c|
        generate_pdf(c)
      end
      generate_zip
    else render '_error.html.erb'
    end
  end
  def generate_pdf(contributor)
    kit = PDFKit.new("<center> <h1> PDF #{contributor.number} </h1> <br> 
<h2>the award goes to </h2><br><h1> #{contributor.login} <h1> </center>")
    kit.to_file("pdfs/#{contributor.login}.pdf")
  end
  def download_pdf
    send_file(
      "#{Rails.root}/pdfs/#{params[:a]}.pdf",
      filename: "#{params[:a]}.pdf",
      type: "application/pdf"
    )
  end
  def generate_zip
    system 'zip -r zip/pdfs.zip pdfs'
  end
  def download_zip
    send_file(
      "#{Rails.root}/zip/pdfs.zip",
      filename: "pdfs.zip",
      type: "application/zip"
    )
  end
  def empty_folder
    ## Empty folder from past results
    system 'rm pdfs/*'
    system 'rm zip/*'
  end
end
