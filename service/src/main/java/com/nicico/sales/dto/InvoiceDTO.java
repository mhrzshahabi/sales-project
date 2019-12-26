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
public class InvoiceDTO {
	@NotNull
	@ApiModelProperty(required = true)
	private Long shipmentId;
	private String invoiceNo;
	private String invoiceDate;
	private String invoiceType;
	private Double net;
	private Double grass;
	private Double unitPrice;
	private String unitPriceCurrency;
	private Double invoiceValue;
	private String invoiceValueCurrency;
	private Double paidPercent;
	private String paidStatus;
	private Double Depreciation;
	private Double otherCost;
	private Double gold;
	private Double silver;
	private Double copper;
	private Double molybdenum;
	private Double molybdJenumUnitPrice;
	private Double copperUnitPrice;
	private Double silverUnitPrice;
	private Double goldUnitPrice;
	private Long bolHeaderId;
	private String priceBase;
	private Double molybdenumContent;
	private Double commercialInvoceValue;
	private Double commercialInvoceValueNet;
	private Double invoiceValueD;
	private String rateBase;
	private Double rate2dollar;
	private Double invoiceValueUp;
	private Double copperIns;
	private Double copperDed;
	private Double copperCal;
	private Double silverIns;
	private Double silverDed;
	private Double silverOun;
	private Double silverCal;
	private Double goldIns;
	private Double goldDed;
	private Double goldOun;
	private Double goldCal;
	private Double subTotal;
	private Double treatCost;
	private Double refinaryCostCU;
	private Double refinaryCostCUPer;
	private Double refinaryCostCUCal;
	private Double refinaryCostCUTot;
	private Double refinaryCostAG;
	private Double refinaryCostAGPer;
	private Double refinaryCostAGTot;
	private Double refinaryCostAU;
	private Double refinaryCostAUPer;
	private Double refinaryCostAUTot;
	private Double subTotalDeduction;
	private String priceReference;
	private String priceFunction;
	private String priceFromDate;
	private String priceToDate;
	private Long sellerId;
	private Long buyerId;
	private String processId;




	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("InvoiceInfo")
	public static class Info extends InvoiceDTO {
		private Long id;
		private Date createdDate;
		private String createdBy;
		private Date lastModifiedDate;
		private String lastModifiedBy;
		private Integer version;
		private ContactDTO.ContactInfoTuple seller;
		private ContactDTO.ContactInfoTuple buyer;
	}



	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("InvoiceCreateRq")
	public static class Create extends InvoiceDTO {
	}



	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("InvoiceUpdateRq")
	public static class Update extends InvoiceDTO {
		@NotNull
		@ApiModelProperty(required = true)
		private Long id;
		@NotNull
		@ApiModelProperty(required = true)
		private Integer version;
	}



	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("InvoiceDeleteRq")
	public static class Delete {
		@NotNull
		@ApiModelProperty(required = true)
		private List<Long> ids;
	}



	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	@ApiModel("InvoiceSpecRs")
	public static class InvoiceSpecRs {
		private SpecRs response;
	}

	// ---------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	public static class SpecRs {
		private List<InvoiceDTO.Info> data;
		private Integer status;
		private Integer startRow;
		private Integer endRow;
		private Integer totalRows;
	}
}
