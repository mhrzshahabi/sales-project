package com.nicico.sales.dto;


import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.NonNull;
import lombok.Setter;
import lombok.experimental.Accessors;

import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.List;

@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class AnalysisMoDTO {

    private String lotName;

    private Double mo;

    private Double cu;

    private Double si;

    private Double pb;

    private Double s;

    private Double c;

    private Double p;


    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("AnalysisMoInfo")
    public static class Info extends AnalysisMoDTO {
        private Long id ;
        private Date createDate;
        private String createdBy;
        private Date lastModifiedDate;
        private String lastModifiedBy;
        private Integer version;
    }


    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("AnalysisMoCreateRq")
    public static class Create extends AnalysisMoDTO {

    }


    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("AnalysisMoUpdateRq")
    public static class Update extends AnalysisMoDTO {
        @NonNull
        @ApiModelProperty(required = true)
        private Long id;
    }


    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("AnalysisMoDeleteRq")
    public static class Delete{
        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }

}
