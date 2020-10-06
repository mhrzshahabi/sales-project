package com.nicico.sales.dto.report;

import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import java.util.List;

@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ReportDTO {

    @Getter
    @Setter
    @Accessors(chain = true)
    @JsonInclude(JsonInclude.Include.NON_NULL)
    @ApiModel("FieldData")
    public static class FieldData {

        private String name;
        private String titleFA;
        private String titleEN;
        private String type;
        private Boolean hidden;
        private Boolean canFilter;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @JsonInclude(JsonInclude.Include.NON_NULL)
    @ApiModel("RestData")
    public static class RestData {

        private String url;
        private String nameFA;
        private String nameEN;
        private String method;
        private List<FieldData> fields;
    }

}
