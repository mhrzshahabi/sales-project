package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.dto.contract.ContractDetailValueDTO;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import javax.validation.constraints.NotNull;
import java.util.List;

@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class CDTPDynamicTableValueDTO {
    private Long id;
    private Long cdtpDynamicTableId;
    private Integer rowNum;
    private String value;
    private String fieldName;
    private Long contractDetailValueId;
    private String description;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("CDTPDynamicTableValueInfo")
    public static class Info extends CDTPDynamicTableValueDTO implements Comparable<Info> {
        private Long id;
        private CDTPDynamicTableDTO.Info cdtpDynamicTable;

        @Override
        public int compareTo(Info info) {
            if (info==null)return this.getRowNum();
            return this.getRowNum() - info.getRowNum();
        }


//        private ContractDetailValueDTO.Info contractDetailValue;
    }


    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("CDTPDynamicTableValueCreateRq")
    public static class Create extends CDTPDynamicTableValueDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("CDTPDynamicTableValueUpdateRq")
    public static class Update extends CDTPDynamicTableValueDTO {
        private Long id;
        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("CDTPDynamicTableValueDeleteRq")
    public static class Delete {
        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
