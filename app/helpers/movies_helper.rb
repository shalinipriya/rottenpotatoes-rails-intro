module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
	
  def getHeaderClass(header)
	if(header=='title' && (params[:sort]=='title'))
		return 'hilite'
	end
	if(header=='release' && (params[:sort]=='release'))
		return 'hilite'
	end
	return nil
  end
end
