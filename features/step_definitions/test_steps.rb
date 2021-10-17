Dado /^los datos iniciales$/ do
  @test = true
end
  
Cuando /^realizo la prueba$/ do
  @testValidation =  true
end

Entonces /^verifico su correcto funcionamiento$/ do
  expect(@testValidation).to eq( @test)
end


  