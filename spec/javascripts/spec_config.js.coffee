#= require backbone
#= require cartodb
#= require sinon
#= require chai-factories

#sql = chai.factory('sql', { execute:  })
#sql = new cartodb.SQL(user: "deciob")
#xhr = sinon.useFakeXMLHttpRequest()
#stub = sinon.stub(sql, "execute")

fake_city_response = {
  time: 0.009,
  total_rows: 3,
  rows: [
    {
    cartodb_id: 309,
    continent: "Asia",
    country: "India",
    iso_a2: "IN",
    latitude: 21.2,
    longitude: 81.66,
    pop1950: 88000,
    pop1955: 109000,
    pop1960: 136000,
    pop1965: 165000,
    pop1970: 200000,
    pop1975: 255000,
    pop1980: 327000,
    pop1985: 387000,
    pop1990: 453000,
    pop1995: 553000,
    pop2000: 680000,
    pop2005: 858000,
    pop2010: 1088000,
    pop2015: 1361000,
    pop2020: 1621000,
    pop2025: 1874000,
    region_un: "Asia",
    region_wb: "South Asia",
    subregion: "Southern Asia",
    urban_aggl: "Raipur"
    },
    {
    cartodb_id: 1,
    continent: "Asia",
    country: "Afghanistan",
    iso_a2: "AF",
    latitude: 34.54,
    longitude: 69.17,
    pop1950: 129000,
    pop1955: 185000,
    pop1960: 265000,
    pop1965: 369000,
    pop1970: 472000,
    pop1975: 674000,
    pop1980: 978000,
    pop1985: 1185000,
    pop1990: 1332000,
    pop1995: 1616000,
    pop2000: 1963000,
    pop2005: 2856000,
    pop2010: 3052000,
    pop2015: 3402000,
    pop2020: 4136000,
    pop2025: 5126000,
    region_un: "Asia",
    region_wb: "South Asia",
    subregion: "Southern Asia",
    urban_aggl: "Kabul"
    },
    {
    cartodb_id: 2,
    continent: "Africa",
    country: "Algeria",
    iso_a2: "DZ",
    latitude: 36.76,
    longitude: 3.05,
    pop1950: 516000,
    pop1955: 623000,
    pop1960: 872000,
    pop1965: 1081000,
    pop1970: 1281000,
    pop1975: 1507000,
    pop1980: 1621000,
    pop1985: 1672000,
    pop1990: 1819000,
    pop1995: 2036000,
    pop2000: 2278000,
    pop2005: 2548000,
    pop2010: 2851000,
    pop2015: 3203000,
    pop2020: 3608000,
    pop2025: 3977000,
    region_un: "Africa",
    region_wb: "Middle East & North Africa",
    subregion: "Northern Africa",
    urban_aggl: "El Djazaïr (Algiers)"
    }
  ]
}

@spec_config = 
  test: yes
  fake_city_response: JSON.stringify fake_city_response
  #sql: stub
