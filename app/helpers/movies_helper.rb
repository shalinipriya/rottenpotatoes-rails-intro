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

  def testChecked?(rating)
	rating_checked = params[:ratings]
	return true if rating_checked.nil?
	rating_checked.include?(rating) 
  end
end
