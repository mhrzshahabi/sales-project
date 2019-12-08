package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.core.util.mail.MailUtil;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.ShipmentEmailDTO;
import com.nicico.sales.iservice.IShipmentEmailService;
import com.nicico.sales.model.entities.base.ShipmentEmail;
import com.nicico.sales.repository.ShipmentEmailDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.mail.MessagingException;
import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class ShipmentEmailService implements IShipmentEmailService {

	private final ShipmentEmailDAO shipmentEmailDAO;
	private final ModelMapper modelMapper;
	private final MailUtil mailUtil;
	@Transactional(readOnly = true)
	public ShipmentEmailDTO.Info get(Long id) {
		final Optional<ShipmentEmail> slById = shipmentEmailDAO.findById(id);
		final ShipmentEmail shipmentEmail = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ShipmentEmailNotFound));

		return modelMapper.map(shipmentEmail, ShipmentEmailDTO.Info.class);
	}

	@Transactional(readOnly = true)
	@Override
	public List<ShipmentEmailDTO.Info> list() {
		final List<ShipmentEmail> slAll = shipmentEmailDAO.findAll();

		return modelMapper.map(slAll, new TypeToken<List<ShipmentEmailDTO.Info>>() {
		}.getType());
	}

	@Transactional
	@Override
	public ShipmentEmailDTO.Info create(ShipmentEmailDTO.Create request)throws MessagingException {
		final ShipmentEmail shipmentEmail = modelMapper.map(request, ShipmentEmail.class);
                mailUtil.sendGoogleEmailMessage(shipmentEmail.getEmailTo(),shipmentEmail.getEmailCC().split(","),null
                        ,shipmentEmail.getEmailSubject(),shipmentEmail.getEmailBody(),
                        null,null);
//                        new ArrayList<byte[]>(){{add(content);}}
//                        ,new ArrayList<String>(Arrays.asList(new String[]{"text.txt"})));
		try {
			mailUtil.sendNicicoEmailMessage(shipmentEmail.getEmailTo(),shipmentEmail.getEmailCC().split(","),null
					,shipmentEmail.getEmailSubject(),shipmentEmail.getEmailBody(),
						null,null);
		} catch (Exception e) {
			e.printStackTrace();
		}
//            		 new ArrayList<byte[]>(){{add(content);}}
//                    ,new ArrayList<String>(Arrays.asList(new String[]{"text.txt"})));

		return save(shipmentEmail);
	}

	@Transactional
	@Override
	public ShipmentEmailDTO.Info update(Long id, ShipmentEmailDTO.Update request) {
		final Optional<ShipmentEmail> slById = shipmentEmailDAO.findById(id);
		final ShipmentEmail shipmentEmail = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ShipmentEmailNotFound));

		ShipmentEmail updating = new ShipmentEmail();
		modelMapper.map(shipmentEmail, updating);
		modelMapper.map(request, updating);

		return save(updating);
	}

	@Transactional
	@Override
	public void delete(Long id) {
		shipmentEmailDAO.deleteById(id);
	}

	@Transactional
	@Override
	public void delete(ShipmentEmailDTO.Delete request) {
		final List<ShipmentEmail> shipmentEmails = shipmentEmailDAO.findAllById(request.getIds());

		shipmentEmailDAO.deleteAll(shipmentEmails);
	}

	@Transactional(readOnly = true)
	@Override
	public TotalResponse<ShipmentEmailDTO.Info> search(NICICOCriteria criteria) {
		return SearchUtil.search(shipmentEmailDAO, criteria, instruction -> modelMapper.map(instruction, ShipmentEmailDTO.Info.class));
	}

	// ------------------------------

	private ShipmentEmailDTO.Info save(ShipmentEmail shipmentEmail) {
		final ShipmentEmail saved = shipmentEmailDAO.saveAndFlush(shipmentEmail);
		return modelMapper.map(saved, ShipmentEmailDTO.Info.class);
	}
}
