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
public class InvoiceTypeDTO {

    private String title;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("InvoiceTypeInfo")
    public static class Info extends InvoiceTypeDTO {
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
    @ApiModel("InvoiceTypeCreateRq")
    public static class Create extends InvoiceTypeDTO {

    }


    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("InvoiceTypeUpdateRq")
    public static class Update extends InvoiceTypeDTO {
        @NotNull
        @ApiModelProperty(required = true)
        private Long id;

        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("InvoiceTypeDeleteRq")
    public static class Delete {
        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }


}
