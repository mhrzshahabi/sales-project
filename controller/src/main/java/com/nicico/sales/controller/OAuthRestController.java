package com.nicico.sales.controller;

import com.nicico.copper.oauth.common.dto.OAPermissionDTO;
import com.nicico.sales.iservice.IOAuthApiService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/oauth")
public class OAuthRestController {

	private final IOAuthApiService oAuthApiService;

	// ------------------------------

	@PostMapping(value = "/permissions")
	public ResponseEntity<OAPermissionDTO.Info> createPermission(@RequestBody OAPermissionDTO.Create request) {
		return new ResponseEntity<>(oAuthApiService.createPermission(request), HttpStatus.OK);
	}
}
