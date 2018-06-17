package com.buzzybrains;

import javax.servlet.Filter;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.boot.web.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;

import com.buzzybrains.util.ErrorHandleFilter;


@SpringBootApplication
public class Application extends SpringBootServletInitializer {

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(Application.class);
    }

    public static void main(String[] args) throws Exception {
        SpringApplication.run(Application.class, args);
    }


    @Bean
	protected Filter[] getServletFilters() {
		return new Filter[]{new ErrorHandleFilter()};
	}
    
    @Bean
    public FilterRegistrationBean someFilterRegistration() {

        FilterRegistrationBean registration = new FilterRegistrationBean();
        registration.setFilter(errorHandleFilter());
        registration.addUrlPatterns("/*");
        
        registration.setName("errorHandleFilter");
        registration.setOrder(1);
        return registration;
    } 

    @Bean(name = "errorHandleFilter")
    public Filter errorHandleFilter() {
        return new ErrorHandleFilter();
    }
}