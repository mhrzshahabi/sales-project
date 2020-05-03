package com.nicico.sales;


import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.sales.iservice.warehous.ITozinService2;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = SalesApplication.class)
public class ServiceTest {
    @Autowired
    ITozinService2 tozinService;
    @Autowired
    ObjectMapper objectMapper;

    @Test
    public void tozinDaoTest() throws JsonProcessingException {
//        final List<Tozin2> all = tozinService.list();
//        final String s = objectMapper.writeValueAsString(all);
//        System.out.println(s);
    }
}
