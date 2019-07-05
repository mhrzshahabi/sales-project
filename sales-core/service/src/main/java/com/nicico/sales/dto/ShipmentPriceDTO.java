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
public class ShipmentPriceDTO {
	private Country countryByflag;
	private Long countryByflagId;
	private ShipmentInquiry shipmentInquiry;
	private Long shipmentInquiryId;
	private Shipment shipment;
	@NotNull
	@ApiModelProperty(required = true)
	private Long ShipmentId;
	private ShipmentHeader shipmentHeader;
	private Long shipmentHeaderId;
	private Contact contactByCompany;
	private Long contactByCompanyId;
	private Double capacity;
	private String laycanStart;
	private String cranesNO;
	private Double swbCost;
	private String laycanEnd;
	private Double vat;
	private Double BL_FREE;
	private Double rate;
	private Double THC;
	private String loadingRate;
	private String dischargeRate;
	private Double demurrage;
	private Double dispatch;
	private Double freight;
	private String vesselName;
	private String yearOfBuilt;
	private String imo;
	private String holds;
	private String hatch;
	private String classType;
	private String ETA;

	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ShipmentPriceInfo")
	public static class Info extends ShipmentPriceDTO {
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
	@ApiModel("ShipmentPriceCreateRq")
	public static class Create extends ShipmentPriceDTO {
	}

	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ShipmentPriceUpdateRq")
	public static class Update extends ShipmentPriceDTO {
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
	@ApiModel("ShipmentPriceDeleteRq")
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
	@ApiModel("ShipmentPriceSpecRs")
	public static class ShipmentPriceSpecRs {
		private SpecRs response;
	}

	// ---------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	public static class SpecRs {
		private List<ShipmentPriceDTO.Info> data;
		private Integer status;
		private Integer startRow;
		private Integer endRow;
		private Integer totalRows;
	}
}
