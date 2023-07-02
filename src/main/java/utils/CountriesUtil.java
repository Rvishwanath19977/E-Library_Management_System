/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import Countries.Countries;
import Countries.Country;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.File;
import java.io.IOException;
import java.util.List;

/**
 *
 * @author vishwanath
 */
public class CountriesUtil {
    
    ObjectMapper objectMapper = new ObjectMapper();
    private final Countries countries; 

    public CountriesUtil() throws IOException {
        this.countries = objectMapper.readValue(new File("/Users/michael/NetBeansProjects/ELibrary/src/main/java/Countries/countries.json"), Countries.class);
    }
    
    public List<Country> getAllCountries() throws IOException {       
        List<Country> deserializedCountries = this.countries.getCountries();
        return deserializedCountries;
    }
    
    public String getCountryByCountryCode(String code) {
        
        String countryName = "No Country";
        
        List<Country> deserializedCountries = this.countries.getCountries();
        for(int i = 0; i < deserializedCountries.size(); i++) {
                    
            if(deserializedCountries.get(i).getCode().equals(code)) {
                return deserializedCountries.get(i).getName();
            }
        }
        
        return countryName;
    }
}
