package com.nicico.sales;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(scanBasePackages = {"com.nicico"})
public class SalesWebApplication {

	public static void main(String[] args) {
		SpringApplication.run(SalesWebApplication.class, args);
	}
}
