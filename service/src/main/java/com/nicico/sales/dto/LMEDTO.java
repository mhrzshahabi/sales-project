package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.model.entities.warehouse.Element;
import com.nicico.sales.model.enumeration.PriceBaseReference;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class LMEDTO {

    @Temporal(TemporalType.TIMESTAMP)
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date lmeDate;
    private Long elementId;
    private PriceBaseReference priceBaseReference;
    private BigDecimal price;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("LMEInfo")
    public static class Info extends LMEDTO {
        private ElementDTO.Info element;

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
    @ApiModel("LMECreateRq")
    public static class Create extends LMEDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("LMEUpdateRq")
    public static class Update extends LMEDTO {
        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("LMEDeleteRq")
    public static class Delete {
        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
