package com.nicico.sales;


import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.sales.model.entities.warehouse.Tozin2;
import com.nicico.sales.repository.warehouse.TozinDAO2;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.Arrays;
import java.util.List;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = SalesApplication.class)
public class DaoTest {
    @Autowired
    TozinDAO2 tozinDAO;
    @Autowired
    ObjectMapper objectMapper;

    @Test
    public void tozinDaoTest() throws JsonProcessingException {
        String[] aa = {
                "4-1491220",
                "1-1493951",
                "1-1634236",
                " 1-1590179",
                "1-9367",
                "1-74621",
                "1-74381",
                "1-74381",
                "1-74381",
                "4-94194",
                "4-94194",
                "1-74381",
                "1-74381",
                "1-74381"
        };
        final List<String> strings = Arrays.asList(aa);
        final List<Tozin2> allByTozinIdList = tozinDAO.findAllByTozinIdList(strings);
        final String s = objectMapper.writeValueAsString(allByTozinIdList);
        System.out.println(s);
    }
}
