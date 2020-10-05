package com.nicico.sales.dto.report;

import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ReportDTO {

    @ApiModel("RestData")
    public static class RestData {

        private String url;
        private String name;
        private String method;
    }

}
