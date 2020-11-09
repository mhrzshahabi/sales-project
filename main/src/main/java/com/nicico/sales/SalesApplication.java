package com.nicico.sales;

import com.nicico.copper.common.web.client.StorageClient;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication(scanBasePackages = {"com.nicico"})
@EnableJpaAuditing(modifyOnCreate = false, auditorAwareRef = "auditorProvider")
@EntityScan(basePackages = {"com.nicico.sales.model"})
@EnableJpaRepositories("com.nicico.sales.repository")
@EnableFeignClients(clients = {StorageClient.class})
public class SalesApplication implements CommandLineRunner {
    public static void main(String[] args) {
        SpringApplication.run(SalesApplication.class, args);
    }

    @Override
    public void run(String... args) throws Exception {

    }
}