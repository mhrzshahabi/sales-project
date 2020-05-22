//package com.nicico.sales.iservice.contract;
//
//import com.nicico.copper.common.domain.criteria.NICICOCriteria;
//import com.nicico.copper.common.dto.grid.TotalResponse;
//import com.nicico.copper.common.dto.search.SearchDTO;
//import com.nicico.sales.dto.contract.IncotermStepsDTO;
//
//import java.util.List;
//
//public interface IIncotermStepsService {
//
//    IncotermStepsDTO.Info get(Long id);
//
//    List<IncotermStepsDTO.Info> getAll(List<Long> ids);
//
//    List<IncotermStepsDTO.Info> list();
//
//    IncotermStepsDTO.Info create(IncotermStepsDTO.Create request);
//
//    List<IncotermStepsDTO.Info> createAll(List<IncotermStepsDTO.Create> requests);
//
//    IncotermStepsDTO.Info update(IncotermStepsDTO.Update request);
//
//    IncotermStepsDTO.Info update(Long id, IncotermStepsDTO.Update request);
//
//    List<IncotermStepsDTO.Info> updateAll(List<IncotermStepsDTO.Update> requests);
//
//    List<IncotermStepsDTO.Info> updateAll(List<Long> ids, List<IncotermStepsDTO.Update> requests);
//
//    void delete(Long id);
//
//    void deleteAll(IncotermStepsDTO.Delete request);
//
//    TotalResponse<IncotermStepsDTO.Info> search(NICICOCriteria request);
//
//    SearchDTO.SearchRs<IncotermStepsDTO.Info> search(SearchDTO.SearchRq request);
//}
