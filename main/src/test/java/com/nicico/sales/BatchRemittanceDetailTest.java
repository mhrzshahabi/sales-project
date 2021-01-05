package com.nicico.sales;

import com.nicico.sales.repository.warehouse.RemittanceDetailDAO;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.ArrayList;

@SpringBootTest
@RunWith(value = SpringRunner.class)
public class BatchRemittanceDetailTest {
@Autowired
    private RemittanceDetailDAO remittanceDetailDAO;
@Test
    public void brdt(){
    final ArrayList<Long> objects = new ArrayList<>();
    objects.add(1541L);
    objects.add(1540L);
    objects.add(1000L);
    remittanceDetailDAO.remittanceDetailByWeightCount(39870L,objects,2555L).get(0).get(1);
    remittanceDetailDAO.remittanceDetailByWeight(39870L,objects,2555L,"saebb",
            39101L,57015L);
}

}
