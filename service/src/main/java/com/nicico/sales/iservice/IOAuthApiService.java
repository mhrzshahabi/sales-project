package com.nicico.sales.iservice;

import com.nicico.copper.oauth.common.dto.OAPermissionDTO;

public interface IOAuthApiService {

	OAPermissionDTO.Info createPermission(OAPermissionDTO.Create request);
}
