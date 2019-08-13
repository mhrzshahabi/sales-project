package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.model.entities.base.*;
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
public class ProvisionalInvoiceDTO {
	@NotNull
	@ApiModelProperty(required = true)
	private String refNumber;
	private String refDate;
	private String bolNumber;
	private String switched;
	private String from;
	private String to;
	private Float netWet;
	private String priceBaseFrom;
	private String priceBaseTO;
	private Float LMEcopper;
	private Float LMEsilver;
	private Float LMEgold;
	private Float totalNetWet;
	private Float totalNetDry;
	private Float totalMoisture;
	private Float subtotal;
	private Float subDeductions;
	private Shipment shipment;
	private Long shipmentId;
	private Contact contact;
	private Long contactId;
	private BolHeader bolHeader;
	private Long bolHeaderId;
	private Contract contract;
	private Long contractId;
	private Material material;
	private Long materialId;

	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ProvisionalInvoiceInfo")
	public static class Info extends ProvisionalInvoiceDTO {
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
	@ApiModel("ProvisionalInvoiceCreateRq")
	public static class Create extends ProvisionalInvoiceDTO {
	}

	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ProvisionalInvoiceUpdateRq")
	public static class Update extends ProvisionalInvoiceDTO {
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
	@ApiModel("ProvisionalInvoiceDeleteRq")
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
	@ApiModel("ProvisionalInvoiceSpecRs")
	public static class ProvisionalInvoiceSpecRs {
		private SpecRs response;
	}

	// ---------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	public static class SpecRs {
		private List<ProvisionalInvoiceDTO.Info> data;
		private Integer status;
		private Integer startRow;
		private Integer endRow;
		private Integer totalRows;
	}
}
