package com.nicico.sales.iservice;

import com.nicico.copper.oauth.common.dto.OAPermissionDTO;

public interface IOAuthApiService {

    void deletePermission(String permissionKey);

    OAPermissionDTO.Info createPermission(OAPermissionDTO.Create request);
}
