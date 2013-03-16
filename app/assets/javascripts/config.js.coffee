#= require ./namespace
#= require ./app_data_strategy

@m.config = 
  cartodb_user: "deciob"
  cartodb_sql_fields: "cartodb_id,continent,country,iso_a2,latitude,longitude," +
    "pop1950,pop1955,pop1960,pop1965,pop1970,pop1975,pop1980,pop1985,pop1990," +
    "pop1995,pop2000,pop2005,pop2010,pop2015,pop2020,pop2025,region_un," +
    "region_wb,subregion,urban_aggl"
  default_year: 1950
  default_country_code: "world"
  dispatcher: _.clone(Backbone.Events)
  dataStrategy: new @m.appDataStrategy()
  