class Keyword < ActiveRecord::Base
  attr_accessible :metaphone, :name, :stem, :synonyms
  serialize :metaphone, Array
  serialize :synonyms, Array

  has_many :wordcounts
  has_many :articles, :through => :wordcounts

  after_create :analyse

  after_save do
    Rails.cache.clear
  end

  def analyse
    raise "Cannot analyse keyword with no name" if self.name.blank?
    self.stem = Text::PorterStemming.stem( self.name )
    self.metaphone = Text::Metaphone.double_metaphone( self.name )
    self.synonyms = BigHugeThesaurus.synonyms( self.name )
    self.save
  end

  def self.create_all( words )
    words.each { |word| create(:name => word )}
  end
end
