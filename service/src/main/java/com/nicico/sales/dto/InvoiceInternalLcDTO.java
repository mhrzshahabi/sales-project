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
public class InvoiceInternalLcDTO {
	@NotNull
	@ApiModelProperty(required = true)
	private Long id;
	private String lcId;
	private String lcPreFactor;
	private String lcCustomerId;
	private String lcCustomerName;
	private String lcBankLc;
	private String bankLcDescShobeh;
	private Long lcGoodsId;
	private String lcGoodName;
	private String lcDateSedor;
	private String lcDateSarreceid;
	private Long lcMeghdar;
	private Long lcPrice;
	private String lcNumber;
	private Long lcType;
	private String lcTypeDesc;
	private Long lcState;
	private String lcStateDesc;
	private String lcUser;
	private String lcUsername;
	private String lcCodeMarkazHazinehLc;
	private String  lcBankMoameleh;
	private String lcBankMoamelehDescShobeh;
	private String lcBankGroupId;
	private String lcBankGroupDesc;
	private String lcStateInOut;



	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("InvoiceInternalLcInfo")
	public static class Info extends InvoiceInternalLcDTO {
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
	@ApiModel("InvoiceInternalLcCreateRq")
	public static class Create extends InvoiceInternalLcDTO {
	}



	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("InvoiceInternalLcUpdateRq")
	public static class Update extends InvoiceInternalLcDTO {
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
	@ApiModel("InvoiceInternalLcDeleteRq")
	public static class Delete {
		@NotNull
		@ApiModelProperty(required = true)
		private List<Long> ids;
	}



	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	@ApiModel("InvoiceInternalLcSpecRs")
	public static class InvoiceSpecRs {
		private SpecRs response;
	}

	// ---------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	public static class SpecRs {
		private List<InvoiceInternalLcDTO.Info> data;
		private Integer status;
		private Integer startRow;
		private Integer endRow;
		private Integer totalRows;
	}
}
