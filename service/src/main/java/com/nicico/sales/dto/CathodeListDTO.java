package com.nicico.sales.dto;

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
public class CathodeListDTO {

    private String storeId;
    private String tozinId;
    private String productId;
    private String productLabel;
    private Long wazn;
    private Long sheetNumber;
    private Long packingTypeId;
    private Long gdsCode;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("CathodListInfo")
    public static class Info extends CathodeListDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @JsonInclude(JsonInclude.Include.NON_NULL)
    public static class SpecRs {
        private List<CathodeListDTO.Info> data;
        private Integer status;
        private Integer startRow;
        private Integer endRow;
        private Integer totalRows;
    }
}
