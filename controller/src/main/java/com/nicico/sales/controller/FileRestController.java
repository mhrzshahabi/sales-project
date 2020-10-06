package com.nicico.sales.controller;

import com.nicico.sales.dto.FileDTO;
import com.nicico.sales.service.FileService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/files")
public class FileRestController {

	private final FileService fileService;

	@PostMapping
	public ResponseEntity<String> Store(@RequestParam FileDTO.Request request) {
		return new ResponseEntity<>(fileService.store(request), HttpStatus.OK);
	}

	@GetMapping(value = "/{key}")
	public ResponseEntity<Void> retrieve(@PathVariable String key) {
		final FileDTO.Response response = fileService.retrieve(key);
		return new ResponseEntity<>(HttpStatus.OK);
	}

	@DeleteMapping(value = "/{key}")
	public ResponseEntity<Void> delete(@PathVariable String key) {
		fileService.delete(key);
		return new ResponseEntity<>(HttpStatus.OK);
	}

}
