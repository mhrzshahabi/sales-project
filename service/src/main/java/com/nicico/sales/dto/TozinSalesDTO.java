package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.List;

@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class TozinSalesDTO {

    private String customer;
    private String source;
    private String tozinId;
    private String nameKala;
    private Long codeKala;
    private String cardId;
    private String target;
    private String carName;
    private String carNo1;
    private String seller;
    private String isFinal;
    private String date;
    private String tozinDate;
    private String tozinTime;
    private Long sourceId;
    private Long targetId;
    private String sellerId;
    private String customerId;
    private String packName;
    private String unitKala;
    private Long tedad;
    private Long vazn;
    private String condition;
    private Long vazn2;
    private Long vazn1;
    private String carPelak;
    private String carNo3;
    private String haveCode;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("TozinSalesInfo")
    public static class Info extends TozinSalesDTO {
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
