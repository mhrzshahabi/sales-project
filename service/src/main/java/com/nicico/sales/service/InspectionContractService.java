package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.InspectionContractDTO;
import com.nicico.sales.iservice.IInspectionContractService;
import com.nicico.sales.iservice.IShipmentService;
import com.nicico.sales.model.entities.base.InspectionContract;
import com.nicico.sales.model.entities.base.Shipment;
import com.nicico.sales.repository.InspectionContractDAO;
import com.nicico.sales.repository.ShipmentDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.MultiValueMap;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class InspectionContractService implements IInspectionContractService {

	private final InspectionContractDAO inspectionContractDAO;
	private final ShipmentDAO shipmentDAO;
	private final ModelMapper modelMapper;
	private final IShipmentService shipmentService;

	@Transactional(readOnly = true)
	public InspectionContractDTO.Info get(Long id) {
		final Optional<InspectionContract> slById = inspectionContractDAO.findById(id);
		final InspectionContract inspectionContract = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.InspectionContractNotFound));

		return modelMapper.map(inspectionContract, InspectionContractDTO.Info.class);
	}

	@Transactional(readOnly = true)
	@Override
	public List<InspectionContractDTO.Info> list() {
		final List<InspectionContract> slAll = inspectionContractDAO.findAll();

		return modelMapper.map(slAll, new TypeToken<List<InspectionContractDTO.Info>>() {
		}.getType());
	}

	@Transactional
	@Override
	public InspectionContractDTO.Info create(InspectionContractDTO.Create request) {
		final InspectionContract inspectionContract = modelMapper.map(request, InspectionContract.class);

		return save(inspectionContract);
	}

	@Transactional
	@Override
	public InspectionContractDTO.Info update(Long id, InspectionContractDTO.Update request) {
		final Optional<InspectionContract> slById = inspectionContractDAO.findById(id);
		final InspectionContract inspectionContract = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.InspectionContractNotFound));

		InspectionContract updating = new InspectionContract();
		modelMapper.map(inspectionContract, updating);
		modelMapper.map(request, updating);
		return save(updating);
	}

	@Transactional
	@Override
	public void delete(Long id) {
		inspectionContractDAO.deleteById(id);
	}

	@Transactional
	@Override
	public void delete(InspectionContractDTO.Delete request) {
		final List<InspectionContract> inspectionContracts = inspectionContractDAO.findAllById(request.getIds());

		inspectionContractDAO.deleteAll(inspectionContracts);
	}

	@Transactional(readOnly = true)
	@Override
	public SearchDTO.SearchRs<InspectionContractDTO.Info> search(SearchDTO.SearchRq request) {
		return SearchUtil.search(inspectionContractDAO, request, inspectionContract -> modelMapper.map(inspectionContract, InspectionContractDTO.Info.class));
	}
	@Override
	@Transactional(readOnly = true)
	public TotalResponse<InspectionContractDTO.Info> search(MultiValueMap<String, String> criteria) {
		final NICICOCriteria request = NICICOCriteria.of(criteria);

		return SearchUtil.search(inspectionContractDAO, request, entity -> {

			return modelMapper.map(entity, InspectionContractDTO.Info.class);
		});
		}



	private InspectionContractDTO.Info save(InspectionContract inspectionContract) {
		final InspectionContract saved = inspectionContractDAO.saveAndFlush(inspectionContract);
		return modelMapper.map(saved, InspectionContractDTO.Info.class);
	}

	@Transactional
	@Override
	public String getMaterial(Long id){
		InspectionContract ic = inspectionContractDAO.findById(id).orElseThrow(() -> new RuntimeException("*********Inspection not found********"));
		Shipment sh = shipmentDAO.findById(ic.getShipmentId()).orElseThrow(() -> new RuntimeException("*******Shipment not found*********"));
		String mola = sh.getMaterial().getDescl();
		return mola;
	}



	@Transactional
	public String ves(Long id){
		InspectionContract ic = inspectionContractDAO.findById(id).orElseThrow(() -> new RuntimeException("********Inspection not found********"));
		Shipment sh = shipmentDAO.findById(ic.getShipmentId()).orElseThrow(() -> new RuntimeException("*********Shipment not found*********"));
		String ves = sh.getVesselName();
		return ves;
	}


	@Transactional
	public String amount(Long id){
		InspectionContract ic = inspectionContractDAO.findById(id).orElseThrow(() -> new RuntimeException("********Inspection not found*********"));
		Shipment sh = shipmentDAO.findById(ic.getShipmentId()).orElseThrow(() -> new RuntimeException("*********Shipment not found********"));
		String amount = String.valueOf(sh.getAmount());
		return amount;
	}

	@Transactional
	public String port(Long id){
		InspectionContract ic = inspectionContractDAO.findById(id).orElseThrow(() -> new RuntimeException("*******Inspection not found*************"));
		Shipment sh = shipmentDAO.findById(ic.getShipmentId()).orElseThrow(() -> new RuntimeException("**********Shipment not found*********"));
		String port = String.valueOf(sh.getPortByDischarge().getPort());
		return port;
	}

	@Transactional
	public String loading(Long id){
		InspectionContract ic = inspectionContractDAO.findById(id).orElseThrow(() -> new RuntimeException("*******Inspection not found*************"));
		Shipment sh = shipmentDAO.findById(ic.getShipmentId()).orElseThrow(() -> new RuntimeException("**********Shipment not found*********"));
		String loading = String.valueOf(sh.getPortByLoading().getPort());
		return loading;
	}


	@Transactional
	public String buyer(Long id){
		InspectionContract ic = inspectionContractDAO.findById(id).orElseThrow(() -> new RuntimeException("*******Inspection not found*************"));
		Shipment sh = shipmentDAO.findById(ic.getShipmentId()).orElseThrow(() -> new RuntimeException("**********Shipment not found*********"));
		String buyer = String.valueOf(sh.getContact().getNameEN());
		return buyer;
	}

	@Transactional
	public String contractNo(Long id){
		InspectionContract ic = inspectionContractDAO.findById(id).orElseThrow(() -> new RuntimeException("*******Inspection not found*************"));
		Shipment sh = shipmentDAO.findById(ic.getShipmentId()).orElseThrow(() -> new RuntimeException("**********Shipment not found*********"));
		String contractNo = String.valueOf(sh.getContract().getContractNo());
		return contractNo;
	}


	@Transactional
	public List<String> email(Long id) {
		InspectionContract ic = inspectionContractDAO.findById(id).orElseThrow(() -> new RuntimeException("*******Inspection not found*************"));
		Shipment sh = shipmentDAO.findById(ic.getShipmentId()).orElseThrow(() -> new RuntimeException("**********Shipment not found*********"));
		Long buyer = sh.getContact().getId();
		return inspectionContractDAO.email(buyer);
}


	@Transactional
	public List<String> emailSel() {
		return inspectionContractDAO.email(4152L);
	}

}