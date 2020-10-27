package com.nicico.sales.model.enumeration;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum FileStatus {
	NORMAL("NORMAL"),
	DELETED("DELETED");

	// ---------------

	private final String value;
}
