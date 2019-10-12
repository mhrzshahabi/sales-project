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
	private Float net;
	private Float grass;
	private Float unitPrice;
	private String unitPriceCurrency;
	private Float invoiceValue;
	private String invoiceValueCurrency;
	private Float paidPercent;
	private String paidStatus;
	private Float Depreciation;
	private Float otherCost;
	private Float gold;
	private Float silver;
	private Float copper;
	private Float molybdenum;
	private Float molybdJenumUnitPrice;
	private Float copperUnitPrice;
	private Float silverUnitPrice;
	private Float goldUnitPrice;
	private Long bolHeaderId;
	private String priceBase;
	private Float molybdenumContent;
	private Float commercialInvoceValue;
	private Float commercialInvoceValueNet;
	private Float invoiceValueD;
	private String rateBase;
	private Float rate2dollar;
	private Float invoiceValueUp;
	private Float copperIns;
	private Float copperDed;
	private Float copperCal;
	private Float silverIns;
	private Float silverDed;
	private Float silverOun;
	private Float silverCal;
	private Float goldIns;
	private Float goldDed;
	private Float goldOun;
	private Float goldCal;
	private Float subTotal;
	private Float treatCost;
	private Float refinaryCostCU;
	private Float refinaryCostCUPer;
	private Float refinaryCostCUCal;
	private Float refinaryCostCUTot;
	private Float refinaryCostAG;
	private Float refinaryCostAGPer;
	private Float refinaryCostAGTot;
	private Float refinaryCostAU;
	private Float refinaryCostAUPer;
	private Float refinaryCostAUTot;
	private Float subTotalDeduction;
	private String priceReference;
	private String priceFunction;
	private String priceFromDate;
	private String priceToDate;
	private Long sellerId;
	private Long buyerId;
	private String processId;


	// ------------------------------

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

	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("InvoiceCreateRq")
	public static class Create extends InvoiceDTO {
	}

	// ------------------------------

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

	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("InvoiceDeleteRq")
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
