module Presenter

  def Presenter.show(character, method = "txt")
    case method
      when "csv"
        require "presenter_csv"
        PresenterCSV.show(character)
      when "wiki"
        print " == "
        headers.each { 
          |hdr| print "#{character[hdr]} " 
        }
      else
        require "presenter_default"
        PresenterDefault.show(character)
    end
    puts
  end

end
