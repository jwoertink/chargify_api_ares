$: << File.expand_path(File.dirname(__FILE__) + '/../lib')

require 'chargify_api_ares'

# You could load your credentials from a file...
chargify_config = YAML::load_file(File.join(File.dirname(__FILE__), '..', 'config', 'chargify.yml'))

Chargify.configure do |c|
  c.subdomain = chargify_config['subdomain']
  c.api_key   = chargify_config['api_key']
end


# Retrieve a list of all your products
products = Chargify::Product.find(:all)
# => [#<Chargify::Product:0x102cdcac8 @prefix_options={}, @attributes={"name"=>"Chargify API Ares Test", "price_in_cents"=>0, "handle"=>"chargify-api-ares-test", "product_family"=>#<Chargify::Product::ProductFamily:0x102cdbad8 @prefix_options={}, @attributes={"name"=>"Chargify API ARes Test", "handle"=>"chargify-api-ares-test", "id"=>78, "accounting_code"=>nil}>, "id"=>152, "accounting_code"=>nil, "interval_unit"=>"month", "interval"=>1}>]

# Find a single product by id
product = Chargify::Product.find(products.first.id)
# => #<Chargify::Product:0x102ce7540 @prefix_options={}, @attributes={"price_in_cents"=>0, "name"=>"Chargify API Ares Test", "handle"=>"chargify-api-ares-test", "product_family"=>#<Chargify::Product::ProductFamily:0x102ce6ca8 @prefix_options={}, @attributes={"name"=>"Chargify API ARes Test", "handle"=>"chargify-api-ares-test", "id"=>78, "accounting_code"=>nil}>, "id"=>152, "accounting_code"=>nil, "interval_unit"=>"month", "interval"=>1}>

# Find a single product by its handle
product = Chargify::Product.find_by_handle(products.first.handle)
# => #<Chargify::Product:0x102c7a828 @prefix_options={}, @attributes={"price_in_cents"=>0, "name"=>"Chargify API Ares Test", "handle"=>"chargify-api-ares-test", "product_family"=>#<Chargify::Product::ProductFamily:0x102c798b0 @prefix_options={}, @attributes={"name"=>"Chargify API ARes Test", "handle"=>"chargify-api-ares-test", "id"=>78, "accounting_code"=>nil}>, "id"=>152, "accounting_code"=>nil, "interval_unit"=>"month", "interval"=>1}>

product_family = Chargify::ProductFamily.first

# NOTE: [:price_in_cents, :name, :interval, :product_family_id] are all required 
attrs = {
  "price_in_cents" => 5000,
  "name" => 'API Generated Product',
  "handle" => 'api-gen-prod',
  "description" => 'Product made from API call',
  "product_family_id" => product_family.id,
  "interval_unit" => 'month',
  "interval" => 1,
  "require_credit_card" => true,
  "request_credit_card" => true,
  "require_billing_address" => true,
  "request_billing_address" => true
}

product = Chargify::Product.create(attrs)
# => #<Chargify::Product:0x10175a948 @prefix_options={}, @attributes={"name"=>"API Generated Product", "request_billing_address"=>true, "product_family"=>#<Chargify::Product::ProductFamily:0x102c798b0 @prefix_options={}, @attributes={"name"=>"Chargify API ARes Test", "handle"=>"chargify-api-ares-test", "id"=>78, "accounting_code"=>nil}>, "created_at"=>Mon Aug 22 18:46:56 UTC 2011, "return_params"=>nil, "handle"=>"api-gen-prod", "return_url"=>nil, "update_return_url"=>nil, "price_in_cents"=>5000, "require_billing_address"=>true, "accounting_code"=>nil, "expiration_interval"=>nil, "expiration_interval_unit"=>nil, "trial_interval"=>nil, "updated_at"=>Mon Aug 22 18:46:56 UTC 2011, "initial_charge_in_cents"=>nil, "id"=>48649, "require_credit_card"=>true, "trial_price_in_cents"=>nil, "interval"=>1, "description"=>"Product made from API call", "request_credit_card"=>true, "product_family_id"=>78, "archived_at"=>nil, "trial_interval_unit"=>nil, "interval_unit"=>"month"}, @persisted=true>