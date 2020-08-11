package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import java.util.Date;

@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class PercentPerYearDTO {

    private Long year;
    private Double cVat;
    private Double tVat;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("PercentPerYearInfo")
    public static class Info extends PercentPerYearDTO {

        private Long id;
        private Date createdDate;
        private String createdBy;
        private Date lastModifiedDate;
        private String lastModifiedBy;
        private Integer version;
    }

}
