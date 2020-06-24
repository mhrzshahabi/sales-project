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
public class TozinTableDTO {

    private String tozinId;
    private String cardId;
    private String haveCode;
    private String tozinDate;
    private Long sourceId;
    private Long targetId;


    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("TozinTableInfo")
    public static class Info extends TozinTableDTO {

        private Long id;


        // Auditing
        private Date createdDate;
        private String createdBy;
        private Date lastModifiedDate;
        private String lastModifiedBy;
        private Integer version;

        // BaseEntity
        private Boolean editable;
        private List<EStatus> eStatus;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("TozinTableCreateRq")
    public static class Create extends TozinTableDTO {

    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("TozinTableUpdateRq")
    public static class Update extends TozinTableDTO {

        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("TozinTableDeleteRq")
    public static class Delete {

        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}