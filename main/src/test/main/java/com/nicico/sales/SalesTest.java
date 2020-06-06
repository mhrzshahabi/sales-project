package main.java.com.nicico.sales;

import com.nicico.sales.SalesApplication;
import com.nicico.sales.dto.ContractDTO;
import com.nicico.sales.dto.ShipmentDTO;
import com.nicico.sales.model.entities.base.Contract;
import com.nicico.sales.repository.ContractDAO;
import com.nicico.sales.repository.UnitDAO;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.transaction.annotation.Transactional;

import java.util.Arrays;
import java.util.List;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = SalesApplication.class, properties = "spring.main.allow-bean-definition-overriding=true")
public class SalesTest {
    @Autowired
    ModelMapper mapper;
    @Autowired
    ContractDAO dao;
    @Autowired
    UnitDAO unitDAO;

    @Test
    public void testModel() {
        Long[] ids = {89L, 675L, 148L, 453L, 462L, 419L, 423L, 424L, 483L, 525L, 527L, 562L, 563L, 91L, 99L, 100L, 102L, 123L, 150L};
        final List<Long> ids1 = Arrays.asList(ids);
        final List<Contract> all = this.dao.findAllById(ids1);
        final List<ContractDTO.InfoForReport> map = mapper.map(all, new TypeToken<List<ContractDTO.InfoForReport>>() {
        }.getType());
        final ShipmentDTO.InfoWithInvoice map1 = mapper.map(all.get(0).getShipments().get(0), ShipmentDTO.InfoWithInvoice.class);
        System.out.println(map);
    }

    @Test
    @Transactional
    public void updateUnitsFromTozinView() {
        try {
            unitDAO.deleteAllByCreatedByIs("fromView");
            unitDAO.updateUnitsFromTozinView();
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.printf("bagher");
    }

}
