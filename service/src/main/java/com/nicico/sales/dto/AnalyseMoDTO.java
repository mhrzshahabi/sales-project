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
public class AnalyseMoDTO {

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
    @ApiModel("AnalyseProductMOInfo")
    public static class Info extends AnalyseMoDTO {
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
    @ApiModel("AnalyseProductMOCreateRq")
    public static class Create extends AnalyseMoDTO{

    }


    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("AnalyseProductMOUpdateRq")
    public static class Update extends AnalyseMoDTO{
        @NonNull
        @ApiModelProperty(required = true)
        private Long id;
    }


    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("AnalyseProductMODeleteRq")
    public static class Delete{
        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }

}
