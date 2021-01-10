package com.nicico.sales.dto.report;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ReportMethodDTO {

    public String name;
    public String apiUrl;
    public String apiMethod;
    public String annotationNameKey;
    public String annotationReturnType;
    public Boolean annotationReturnTypeIsList;
}
