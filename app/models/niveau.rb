class Niveau < ActiveRecord::Base
	has_many :elements
  
  def serialize
    fileName = "lvl-#{self.tier}-#{self.numero}.xml"
    filePath = Mainconfig.find(1).root
    
    File.open("#{filePath}/#{fileName}" , 'w') do |f| 
		f.puts("<level number='#{self.numero}' tier='#{self.tier}' title='#{self.titre}'>")
		
		self.elements.each do |element|
			currentLine = "\t<#{element.type.xmlTag} x='#{(element.x-0.5) * 16}' y='#{(element.y-0.5) * 16}'"

			element.options.each do |option|
				currentLine << " #{option.name}='#{option.value}'"
			end
			
      if element.type.perfVoisin 
        
        hasOneAbove=false
        hasOneBelow=false
        hasOneOnTheRight=false
        hasOneOnTheLeft=false
        
        if element.x==1
          hasOneOnTheLeft=true
        end
        if element.x==20
          hasOneOnTheRight=true
        end
        if element.y==1
          hasOneBelow=true
        end
        if element.y==30
          hasOneAbove=true
        end
        
        if !hasOneOnTheLeft
          res=Element.where("niveau_id=? and x=? and y=?", self.id,element.x-1, element.y)
          if res.count == 1
            if res[0].type.perfVoisin || res[0].type.id==5|| (res[0].type.id=11 && (res[0].options.first=="NW" || res[0].options.first=="SW"))
              hasOneOnTheLeft=true
            end
          end
        end
        
        if !hasOneOnTheRight
          res=Element.where("niveau_id=? and x=? and y=?", self.id,element.x+1, element.y)
          if res.count == 1
            if res[0].type.perfVoisin || res[0].type.id==5|| (res[0].type.id=11 && (res[0].options.first=="NE" || res[0].options.first=="SE"))
              hasOneOnTheRight=true
            end
          end
        end
        
        if !hasOneBelow
          res=Element.where("niveau_id=? and x=? and y=?", self.id,element.x, element.y-1)
          if res.count == 1
            if res[0].type.perfVoisin || res[0].type.id==5|| (res[0].type.id=11 && (res[0].options.first=="SE" || res[0].options.first=="SW"))
              hasOneBelow=true
            end
          end
        end
        
        if !hasOneAbove
          res=Element.where("niveau_id=? and x=? and y=?", self.id,element.x, element.y+1)
          if res.count == 1
            if res[0].type.perfVoisin || res[0].type.id==5|| (res[0].type.id=11 && (res[0].options.first=="NE" || res[0].options.first=="NW"))
              hasOneAbove=true
            end
          end
        end
        
        currentLine << " hasOneAbove='#{(hasOneAbove)?"1":"0"}' hasOneBelow='#{(hasOneBelow)?"1":"0"}' hasOneOnTheRight='#{(hasOneOnTheRight)?"1":"0"}' hasOneOnTheLeft='#{(hasOneOnTheLeft)?"1":"0"}' "
        
      end
      
			currentLine << "></#{element.type.xmlTag}>"
			
			f.puts(currentLine)
		end
		
		f.puts("</level>")
	end
  end
end
