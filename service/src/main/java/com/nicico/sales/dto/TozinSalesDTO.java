package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.List;

@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class TozinSalesDTO {

    private Long pId;
    private String cardId;
    private String carNo1;
    private String carNo3;
    private String plak;
    private String carName;
    private String customerId;
    private String customer;
    private String sellerId;
    private String seller;
    private String tozinId;
    private String tozinPlantId;
    private Long vazn1;
    private Long vazn2;
    private String condition;
    private Long vazn;
    private Long tedad;
    private Long unitKala;
    private String packName;
    private String haveCode;
    private String date;
    private String tozinDate;
    private String tozinTime;
    private Long codeKala;
    private String nameKala;
    private Long sourceId;
    private String source;
    private Long targetId;
    private String target;
    private String havalehName;
    private String havalehDate;
    private String isFinal;
    private String sourcePlantId;
    private String targetPlantId;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("TozinSalesInfo")
    public static class Info extends TozinSalesDTO {
        private Long id;
        private Date createdDate;
        private String createdBy;
        private Date lastModifiedDate;
        private String lastModifiedBy;
        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("TozinSalesCreateRq")
    public static class Create extends TozinSalesDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("TozinSalesUpdateRq")
    public static class Update extends TozinSalesDTO {
        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("TozinSalesDeleteRq")
    public static class Delete {
        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @JsonInclude(JsonInclude.Include.NON_NULL)
    public static class SpecRs {
        private List<TozinSalesDTO.Info> data;
        private Integer status;
        private Integer startRow;
        private Integer endRow;
        private Integer totalRows;
    }
}
