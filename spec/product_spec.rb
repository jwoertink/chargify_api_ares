require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Chargify::Product do
  
  context 'find by handle' do
    before do
      @handle = 'handle1'
      @existing_product = Factory(:product, :handle => @handle, :id => FactoryGirl.generate(:product_id))
      FakeWeb.register_uri(:get, "#{test_domain}/products/lookup.xml?handle=#{@existing_product.handle}", :body => @existing_product.attributes.to_xml)
    end
  
    it 'finds the correct product by handle' do
      product = Chargify::Product.find_by_handle(@handle)
      product.should eql(@existing_product)
    end
    
    it 'is an instance of Chargify::Product' do
      product = Chargify::Product.find_by_handle(@handle)
      product.should be_instance_of(Chargify::Product)
    end  
  end
  
  context 'create new product' do
    let(:options) do
      {
        "price_in_cents" => 5000,
        "name" => 'API Generated Product',
        "product_family_id" => Chargify::ProductFamily.first.id,
        "interval" => 1
      }
    end
    
    it "should take the attributes and return a new product" do
      new_product = Chargify::Product.create(options)
      new_product.should be_instance_of(Chargify::Product)
    end
    
  end

end