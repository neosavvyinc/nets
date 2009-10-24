package com.neosavvy.spring;

import org.apache.log4j.Logger;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.config.PropertyPlaceholderConfigurer;
import org.springframework.core.io.Resource;


public class PropertyPlaceHolderConfigurer extends
		PropertyPlaceholderConfigurer {

	private static final Logger logger = Logger.getLogger(PropertyPlaceHolderConfigurer.class);
	
	@Override
	public void setLocations(Resource[] locations) {
		
		List<Resource>validLocations = new ArrayList<Resource>();
		for (Resource resource : locations) {
			try {
				resource.getInputStream();
				validLocations.add(resource);
			} catch (IOException e) {
				logger.warn("setLocations(Resource[]) - Failed to find resource file", e); 
			}
		}
		
		super.setLocations(validLocations.toArray(new Resource[]{}));
	}
	

}
