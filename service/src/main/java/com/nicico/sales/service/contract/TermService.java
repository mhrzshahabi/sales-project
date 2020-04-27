package com.nicico.sales.service.contract;

import com.nicico.sales.dto.contract.TermDTO;
import com.nicico.sales.iservice.contract.ITermService;
import com.nicico.sales.model.entities.contract.Term;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class TermService extends GenericService<Term, Long, TermDTO.Create, TermDTO.Info, TermDTO.Update, TermDTO.Delete> implements ITermService {
}