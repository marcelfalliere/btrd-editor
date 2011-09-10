class Element < ActiveRecord::Base
  belongs_to :type
  belongs_to :niveau
  has_many :options, :dependent => :delete_all
  accepts_nested_attributes_for :options, :allow_destroy => true
  
  validate :not_already_something, :on => :create
  def not_already_something
	errors.add(:x, "Coordinate already occupied by another element") unless Element.where("niveau_id=? and x=? and y=?", self.niveau_id, self.x, self.y).count < 1
  end
  
  after_create :init_options
  def init_options
	# en fonction du type, initialiser les options de type key/value
	
	# xG
	if self.type_id==6
		self.options.create({:name=>'coef', :value=>'2'})
	end
	
	# spike
	if self.type_id==5
		self.options.create({:name=>'orientation', :value=>'top'})
	end
	
	# sprite
	if self.type_id==10
		self.options.create({:name=>'fichier', :value=>'top'})
	end
	
	# sprite
	if self.type_id==11
		self.options.create({:name=>'orientation', :value=>'NW'})
	end
	
  end
  
end
