package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.model.enumeration.EStatus;
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
public class CDTPDynamicTableValueDTO {

    private Long colNum;
    private String headerType = "String";
    private String headerValue;
    private String headerKey;

    private String valueType = "String";
    private String displayField;
    private Boolean required;
    private String regexValidator;
    private String defaultValue;
    private Integer maxRows = 0;
    private String description;
    private String initialCriteria;

    private String value;
    private Integer rowNum;
//    private String fieldName;
//    private Long cdtpDynamicTableId;
    private Long contractDetailValueId;
//    private String description;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("CDTPDynamicTableValueInfo")
    public static class Info extends CDTPDynamicTableValueDTO implements Comparable<Info> {

        private Long id;
//        private CDTPDynamicTableDTO.Info cdtpDynamicTable;

        // Auditing
        private Date createdDate;
        private String createdBy;
        private Date lastModifiedDate;
        private String lastModifiedBy;
        private Integer version;

        // BaseEntity
        private Boolean editable;
        private List<EStatus> eStatus;

        @Override
        public int compareTo(Info info) {

            if (info == null) return this.getRowNum();
            return this.getRowNum() - info.getRowNum();
        }
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
