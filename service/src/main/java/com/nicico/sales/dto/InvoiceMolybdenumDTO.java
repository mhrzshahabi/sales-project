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
public class InvoiceMolybdenumDTO {
	private Long id;
	@NotNull
	@ApiModelProperty(required = true)
	private Long invoiceId;
	private String lotNo;
	private Double net;
	private Double grass;
	private Double molybdenumPercent;
	private Double copperPercent;
	private Double molybdenumContent;
	private Double discountPercent;
	private Double priceFee;
	private Double price;


	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("InvoiceMolybdenumInfo")
	public static class Info extends InvoiceMolybdenumDTO {
		private Long id;
		private InvoiceDTO.Info invoice;
		private Date createdDate;
		private String createdBy;
		private Date lastModifiedDate;
		private String lastModifiedBy;
		private Integer version;
	}



	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("InvoiceMolybdenumCreateRq")
	public static class Create extends InvoiceMolybdenumDTO {
	}



	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("InvoiceMolybdenumUpdateRq")
	public static class Update extends InvoiceMolybdenumDTO {
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
	@ApiModel("InvoiceMolybdenumDeleteRq")
	public static class Delete {
		@NotNull
		@ApiModelProperty(required = true)
		private List<Long> ids;
	}



	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	@ApiModel("InvoiceMolybdenumSpecRs")
	public static class InvoiceMolybdenumSpecRs {
		private SpecRs response;
	}

	// ---------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	public static class SpecRs {
		private List<InvoiceMolybdenumDTO.Info> data;
		private Integer status;
		private Integer startRow;
		private Integer endRow;
		private Integer totalRows;
	}
}
