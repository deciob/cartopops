#= require spec_data_strategy
#= require spec_fake_data


@m.spec_config = 
  fake_city_response: @m.spec_fake_data
  dataStrategy: new @m.specDataStrategy @m.spec_fake_data

