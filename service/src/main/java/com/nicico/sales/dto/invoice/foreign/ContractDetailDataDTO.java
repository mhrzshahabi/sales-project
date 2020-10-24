package com.nicico.sales.dto.invoice.foreign;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.dto.MaterialElementDTO;
import com.nicico.sales.dto.UnitDTO;
import com.nicico.sales.dto.contract.ContractDiscountDTO;
import com.nicico.sales.dto.contract.IncotermDTO;
import com.nicico.sales.model.entities.contract.ContractDiscount;
import com.nicico.sales.model.enumeration.PriceBaseReference;
import io.swagger.annotations.ApiModel;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ContractDetailDataDTO {


    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractDetailDataInfo")
    public static class Info extends ContractDetailDataDTO {

        private BigDecimal tc;
        private List<RCData> rc;

        private String priceContent;
        private String quotationalPeriodContent;

        private List<MOASData> MOAS;

        private IncotermDTO.Info incoterm;

        private List<ContractDiscount> discount;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("RCDataRq")
    public static class RCData {

        private BigDecimal price;
        private UnitDTO.Info weightUnit;
        private UnitDTO.Info financeUnit;
        private MaterialElementDTO.Info materialElement;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("MOASDataRq")
    public static class MOASData {

        private Date date;
        private Integer moasValue;
        private Integer workingDayAfter;
        private Integer workingDayBefore;
        private PriceBaseReference priceReference;
        private MaterialElementDTO.Info materialElement;
    }
}
