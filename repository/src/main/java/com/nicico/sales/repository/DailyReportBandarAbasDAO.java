package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.DailyReportBandarAbas;
import com.nicico.sales.model.entities.base.TozinLite;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Set;

@Repository
public interface DailyReportBandarAbasDAO extends JpaRepository<DailyReportBandarAbas, DailyReportBandarAbas.DailyReportBandAbasId>,
        JpaSpecificationExecutor<DailyReportBandarAbas> {

}
