package com.nicico.sales.service;

import com.nicico.sales.iservice.IContactAttachmentService;
import com.nicico.sales.repository.ContactAttachmentDAO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class ContactAttachmentService implements IContactAttachmentService {
	private final ContactAttachmentDAO contactAttachmentDao;

	public Long findNextImageNumber() {
		return contactAttachmentDao.findNextImageNumber();
	}
}
