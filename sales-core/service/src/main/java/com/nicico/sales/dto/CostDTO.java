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
public class CostDTO {
	@NotNull
	@ApiModelProperty(required = true)
	private Long shipmentId;
	private Long sourceInspectorId;
	private Float sourceInspectionCost;
	private String sourceInspectionCurrency;
	private Long destinationInspectorId;
	private Float destinationInspectionCost;
	private String destinationInspectionCurrency;
	private Float otherCost;
	private Float beforePaid;
	private String otherCostCurrency;
	private Long sarcheshmehLabCost;
	private Float umpireCost;
	private String umpireCostCurrency;
	private Float sourceGold;
	private Float sourceSilver;
	private Float sourceCopper;
	private Float sourceMolybdenum;
	private Float destinationGold;
	private Float destinationSilver;
	private Float destinationCopper;
	private Float destinationMolybdenum;
	private Long insuranceId;
	private Float insuranceCost;
	private String insuranceCostCurrency;
	private String insuranceClause;
	private Long inventortRentCost;
	private Long postCost;
	private Float thcCost;
	private Float blFeeCost;
	private Float demandCost;
	private Float contractorCost;
	private Float counterCost;
	private Float disinfectionCost;
	private Float portCost;

	// ------------------------------
	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("CostInfo")
	public static class Info extends CostDTO {
		private ShipmentDTO Shipment;
		private ContactDTO.ContactInfoTuple sourceInspector;
		private ContactDTO.ContactInfoTuple destinationInspector;
		private ContactDTO.ContactInfoTuple insurance;
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
	@ApiModel("CostCreateRq")
	public static class Create extends CostDTO {
	}

	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("CostUpdateRq")
	public static class Update extends CostDTO {
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
	@ApiModel("CostDeleteRq")
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
	@ApiModel("CostSpecRs")
	public static class CostSpecRs {
		private SpecRs response;
	}

	// ---------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	public static class SpecRs {
		private List<CostDTO.Info> data;
		private Integer status;
		private Integer startRow;
		private Integer endRow;
		private Integer totalRows;
	}
}
