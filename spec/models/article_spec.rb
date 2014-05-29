require 'spec_helper'

describe Article do
  let(:article) { FactoryGirl.create(:article) }
  before        { Article.stub(:search_tank).and_return([article]) }
  subject       { article }

  describe ".search" do

    it "matches articles in the database" do
      Article.search(article.title).should include(article)
    end

    context "query does not match anything in the database" do
      it "returns an empty array" do
        Article.stub(:search_tank).and_return([])
        Article.search(SecureRandom.hex(16)).should be_empty
      end
    end

    context "query is an empty string" do
      subject { Article.search ''}
      it { should == Article.all }
    end

    context "query is a single space" do
      subject { Article.search ' ' }
      it { should == Article.all }
    end

    describe ".search titles" do
      it "returns an empty array when the search term is present in an article but not the title" do
        Article.stub(:search_tank).and_return([])
        Article.search_titles(article.preview).should be_empty
      end

      context "query is present in the title" do
        subject { Article.search_titles article.title }
        it { should include(article) }
      end
    end
  end

  describe "#remove_stop_words" do
    it "removes common english words from the string" do
      Article.remove_stop_words('why am I a banana').should eq('banana')
    end
  end

  describe ".find_by_type" do
    it 'returns articles matching type' do
      new_article = Article.create(
          :title => "Every answer you've ever been searching for and a bag of cats",
          :type => 'QuickAnswer'
        )
      result = Article.find_by_type( "QuickAnswer" )
      expect(result.map{|r| r.title }).to include "Every answer you've ever been searching for and a bag of cats"
    end


  end
end

