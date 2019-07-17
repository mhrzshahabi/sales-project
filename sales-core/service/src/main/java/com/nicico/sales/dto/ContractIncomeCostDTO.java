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
public class ContractIncomeCostDTO {
    private String contractNo;
    private String customerFullNameEn;
    private String ProductNameEn;
    private String unitNameEn;
    private Double amount;
    private String totalFreight;
    private Double shipmentAmount;
    private String blDate;
    private Double demurage;
    private Double dispatch;
    private Double freight;
    private String loadingLetter;
    private String month;
    private String vesselName;
    private String invoceDateProvisional;
    private Double netProvisional;
    private String invoiceTypeProvisional;
    private String invoiceNoProvisional;
    private String invoiceValueProvisional;
    private Double invoiceDollarProvisional;
    private Double invoiceEuroProvisional;
    private Double invoiceIRRProvisional;
    private String invoceDateFinal;
    private Double netFinal;
    private String invoiceTypeFinal;
    private String invoiceNoFinal;
    private String invoiceValueFinal;
    private Double invoiceDollarFinal;
    private Double invoiceEuroFinal;
    private Double invoiceIRRFinal;
    private Double costDollar;
    private Double costEuro;
    private Double costIRR;
    private String destinationInspectionCost;
    private String sourceInspectionCost;
    private String insuranceCost;
    private String umpireCost;

	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ContractIncomeCostInfo")
	public static class Info extends ContractIncomeCostDTO {
		private Long id;
		private Date createdDate;
		private String createdBy;
		private Date lastModifiedDate;
		private String lastModifiedBy;
		private Integer version;
	}

	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ContractIncomeCostCreateRq")
	public static class Create extends ContractIncomeCostDTO {
	}

	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ContractIncomeCostUpdateRq")
	public static class Update extends ContractIncomeCostDTO {
		@NotNull
		@ApiModelProperty(required = true)
		private Long id;
		@NotNull
		@ApiModelProperty(required = true)
		private Integer version;
	}

	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ContractIncomeCostDeleteRq")
	public static class Delete {
		@NotNull
		@ApiModelProperty(required = true)
		private List<Long> ids;
	}

	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	@ApiModel("ContractIncomeCostSpecRs")
	public static class ContractIncomeCostSpecRs {
		private SpecRs response;
	}

	// ---------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	public static class SpecRs {
		private List<ContractIncomeCostDTO.Info> data;
		private Integer status;
		private Integer startRow;
		private Integer endRow;
		private Integer totalRows;
	}
}
