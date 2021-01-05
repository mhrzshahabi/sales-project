package com.nicico.sales.enumeration;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum ErrorType {

    BadRequest(400),
    UnAuthorized(401),
    Forbidden(403),
    NotFound(404),
    NotEditable(404),
    NotRemovable(404),
    FinalRecord(404),
    DeActiveRecord(404),
    Send2AccRecord(404),
    ConstraintViolation(404),
    PayloadTooLarge(413),
    Unknown(500),
    NotImplemented(50),
    InvalidData(500),
    InternalServerError(500);

    private final Integer id;
}
