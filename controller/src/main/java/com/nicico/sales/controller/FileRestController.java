package com.nicico.sales.controller;

import com.nicico.sales.dto.FileDTO;
import com.nicico.sales.service.FileService;
import io.swagger.annotations.ApiParam;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.Resource;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/files")
public class FileRestController {

	private final FileService fileService;

	@PostMapping
	public ResponseEntity<String> Store(@ApiParam FileDTO.Request request) {
		return new ResponseEntity<>(fileService.store(request), HttpStatus.OK);
	}

	@GetMapping(value = "/{key}")
	public ResponseEntity<Resource> retrieve(@PathVariable String key) {
		final FileDTO.Response response = fileService.retrieve(key);

		final HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.setContentDisposition(ContentDisposition.parse("attachment; filename=\"" + response.getFileName() + "." + response.getExtension() + "\""));

		final ByteArrayResource resource = new ByteArrayResource(response.getContent());

		return ResponseEntity.ok()
				.headers(httpHeaders)
				.contentLength(response.getContent().length)
				.contentType(MediaType.valueOf(response.getContentType()))
				.body(resource);
	}

	@PostMapping(value = "/tags")
	public ResponseEntity<List<String>> getByTags(@RequestBody Map<String, String> tags) {
		return new ResponseEntity<>(fileService.getByTags(tags), HttpStatus.OK);
	}

	@DeleteMapping(value = "/{key}")
	public ResponseEntity<Void> delete(@PathVariable String key) {
		fileService.delete(key);
		return new ResponseEntity<>(HttpStatus.OK);
	}

}
